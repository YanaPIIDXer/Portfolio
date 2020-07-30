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

module "InnerAPI_SecurityGroup" {
    source = "terraform-aws-modules/security-group/aws"

    name = "InnerAPI_SecurityGroup"
    description = "InnerAPI Security Group"
    vpc_id = module.VPC.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["http-80-tcp", "ssh-tcp"]
}

module "TaskDef_InnerAPI" {
    source = "./ECS/TaskDefinition"

    family = "InnerAPI"
    // 仮にHTTPサーバでも立ててみる。
    container_name = "nginx"
    image = "nginx:latest"
    container_port = 80
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
