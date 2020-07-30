module "InnerAPI_SecurityGroup" {
    source = "terraform-aws-modules/security-group/aws"

    name = "InnerAPI_SecurityGroup"
    description = "InnerAPI Security Group"
    vpc_id = module.VPC.vpc_id

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["http-80-tcp"]
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
    cluster_name = "InnerAPI"
    vpc_id = module.VPC.vpc_id
    task = module.TaskDef_InnerAPI.arn
    key_name = var.key_name
    security_group_id = module.InnerAPI_SecurityGroup.this_security_group_id
    subnet_id = module.VPC.public_subnets[0]
    security_groups = [module.InnerAPI_SecurityGroup.this_security_group_id]
    subnets = [module.VPC.public_subnets[0]]
}
