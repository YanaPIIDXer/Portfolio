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
    image = "nginx:1.14"
    container_port = 80
    host_port = 80
}

module "Cluster_InnerAPI" {
    source = "./ECS"

    name = "InnerAPI"
    family = "InnerAPI"
    task = module.TaskDef_InnerAPI.arn
    security_groups = [module.InnerAPI_SecurityGroup.this_security_group_id]
    subnets = [module.VPC.public_subnets[0]]
}
