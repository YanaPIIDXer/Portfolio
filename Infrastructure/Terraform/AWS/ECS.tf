module "InnerAPI_SecurityGroup" {
    source = "terraform-aws-modules/security-group/aws"

    name = "InnerAPI_SecurityGroup"
    description = "InnerAPI Security Group"
    vpc_id = module.VPC.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["http-80-tcp"]
}

module "ECSAgent_SecurityGroup" {
    source = "terraform-aws-modules/security-group/aws"

    name = "ECSAgent_SecurityGroup"
    description = "ECS Agent Security Group"
    vpc_id = module.VPC.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["ssh-tcp"]

    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
}

module "TaskDef_InnerAPI" {
    source = "./ECS/TaskDefinition"

    family = "InnerAPI"
    container_name = "InnerAPI"
    image = "inner_api:latest"
    container_port = 3000
    host_port = 80
    protocol = "tcp"
}

module "Cluster_InnerAPI" {
    source = "./ECS"

    name = "InnerAPI"
    family = "InnerAPI"
    task = module.TaskDef_InnerAPI.arn
    security_groups = [module.InnerAPI_SecurityGroup.this_security_group_id]
    subnets = [module.VPC.public_subnets[0]]
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

module "InnerAPI_Server" {
    source = "terraform-aws-modules/ec2-instance/aws"

    name = "SlotSNS_InnerAPIServer"
    instance_count = 1
    ami = "ami-0763fff45988661c8"     // ECSエージェント入りのami
    instance_type = "t2.micro"
    vpc_security_group_ids = [
        module.InnerAPI_SecurityGroup.this_security_group_id,
        module.ECSAgent_SecurityGroup.this_security_group_id
    ]
    subnet_id = module.VPC.public_subnets[0]
    iam_instance_profile = aws_iam_instance_profile.ECS_Role_Profile.name
    user_data = <<USERDATA
#!/bin/bash
echo ECS_CLUSTER=InnerAPI >> /etc/ecs/ecs.config
    USERDATA
}
