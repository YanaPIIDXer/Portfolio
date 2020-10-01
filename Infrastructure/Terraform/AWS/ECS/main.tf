data "template_file" "template" {
  template = <<USERDATA
#!/bin/bash

sudo yum update

# Append to Cluster
echo "ECS_CLUSTER=${var.name}" >> /etc/ecs/ecs.config

# Update Amazon ECS Container Agent
sudo yum update -y ecs-init
sudo systemctl restart docker

# Install CodeDeploy Agent 
sudo yum install ruby
sudo yum install wget
cd /home/ec2-user
# HACK: It works ONLY "Asia/Tokyo" resion. (ap-northeast-1)
wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
USERDATA
}

// HACK:自作Module使いたいけど、SecurityGroupの指定に対応するのがかなり面倒なので生Resource使用。
resource "aws_security_group" "health_check_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-health_check_sg"
  }
}

resource "aws_security_group_rule" "health_check_sg_ingress_rule" {
  security_group_id = aws_security_group.health_check_sg.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 65535
  source_security_group_id = module.service.elb_sg_id
}

resource "aws_launch_template" "container_instance" {
  disable_api_termination              = false
  name_prefix                          = var.name
  image_id                             = var.ami
  key_name                             = var.key_name
  instance_type                        = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  user_data                            = base64encode("${data.template_file.template.rendered}")
  network_interfaces {
    security_groups             = concat(var.security_groups, [aws_security_group.health_check_sg.id])
    associate_public_ip_address = true
    delete_on_termination       = true
  }
  iam_instance_profile {
    name = "ecsInstanceRole"
  }
}

resource "aws_autoscaling_group" "container_instance" {
  lifecycle {
    create_before_destroy = true
  }

  name = var.name

  launch_template {
    id      = aws_launch_template.container_instance.id
    version = "$Latest"
  }

  desired_capacity     = 1
  min_size             = 0
  max_size             = 1
  health_check_type    = "EC2"
  termination_policies = ["OldestLaunchConfiguration", "Default"]
  vpc_zone_identifier  = var.subnets

  depends_on = [module.service]
}

resource "aws_ecs_cluster" "cluster" {
  name = var.name
}

resource "aws_autoscaling_policy" "autoscaling" {
  name                   = var.name
  autoscaling_group_name = aws_autoscaling_group.container_instance.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = "ClusterName"
        value = var.name
      }

      metric_name = "autoscaling"
      namespace   = "AWS/ECS"
      statistic   = "Average"
      unit        = "None"
    }

    target_value = "50.0"
  }
}

module "service" {
  source                 = "./Service"
  name                   = var.name
  cluster_name           = aws_ecs_cluster.cluster.name
  vpc_id                 = var.vpc_id
  subnets                = var.subnets
  task_definition_arn    = var.task_definition_arn
  container_name         = var.container_name
  container_port         = var.container_port
}
