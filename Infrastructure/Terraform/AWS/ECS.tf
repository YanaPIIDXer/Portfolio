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
    security_groups = []
    subnets = [module.VPC.public_subnets[0]]
}
