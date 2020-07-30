module "ECSAgent_SecurityGroup" {
    source = "terraform-aws-modules/security-group/aws"

    name = "ECSAgent_SecurityGroup"
    description = "ECS Agent Security Group"
    vpc_id = var.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["ssh-tcp"]

    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
}

resource "aws_ecs_cluster" "cluster" {
    name = var.name
}

resource "aws_ecs_service" "default" {
    name = var.name
    cluster = aws_ecs_cluster.cluster.arn
    task_definition = var.task
    desired_count = 1
    launch_type = "EC2"
    depends_on = [module.EC2_Server]
}

data "aws_iam_policy_document" "EC2_AssumeRole" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "ECS_Role" {
    name = "ECSRole"
    assume_role_policy = data.aws_iam_policy_document.EC2_AssumeRole.json
}

resource "aws_iam_role_policy_attachment" "ECS_RoleAttachment_ServiceAccess" {
    role = aws_iam_role.ECS_Role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ECS_RoleAttachment_ContainerAccess" {
    role = aws_iam_role.ECS_Role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_instance_profile" "ECS_Role_Profile" {
    name = "ECS_Role_Profile"
    role = aws_iam_role.ECS_Role.name
}

module "EC2_Server" {
    source = "terraform-aws-modules/ec2-instance/aws"

    name = var.name
    instance_count = 1
    ami = "ami-0763fff45988661c8"     // ECSエージェント入りのami
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = [
        var.security_group_id,
        module.ECSAgent_SecurityGroup.this_security_group_id
    ]
    subnet_id = var.subnet_id
    iam_instance_profile = aws_iam_instance_profile.ECS_Role_Profile.name
    user_data = <<USERDATA
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
echo ECS_ENGINE_AUTH_TYPE=docker >> /etc/ecs/ecs.config
echo 'ECS_ENGINE_AUTH_DATA={"https://${var.docker_uri}/":{"username":"${var.docker_user_name}","password":"${var.docker_password}","email":"${var.docker_email}"}}' >> /etc/ecs/ecs.config
ECS_LOGLEVEL=debug
USERDATA
}
