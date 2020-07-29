module "TaskDef_InnerAPI" {
    source = "./ECS/TaskDefinition"

    family = "InnerAPI"
    // 仮にHTTPサーバでも立ててみる。
    container_name = "nginx"
    image = "nginx:1.14"
    container_port = 80
    host_port = 80
}
