// 内部APIのタスク定義
module "inner_api_task_definition" {
  source           = "./ECSTask"
  family           = "InnerAPI"
  container_name   = "InnerAPI"
  container_image  = "${var.ecr_domain}/inner_api:latest"
  container_port   = 3000
  host_port        = 0
  task_role_arn    = var.ecs_task_role_arn
  execute_role_arn = var.ecs_task_role_arn
  environments = [
    {
      "name" : "DATABASE_HOST",
      "value" : "${module.database.address}"
    },
    {
      "name" : "DATABASE_USERNAME",
      "value" : "root"
    },
    {
      "name" : "DATABASE_PASSWORD",
      "value" : "password"
    },
    {
      "name" : "DATABASE_NAME",
      "value" : "slot_sns"
    },
    {
      "name" : "BUNDLER_VERSION",
      "value" : "2.0.2"
    },
    {
      "name" : "RAILS_ENV",
      "value" : "development"
    }
  ]
}

module "inner_api_sg" {
  source         = "./SecurityGroup"
  vpc_id         = module.vpc.vpc_id
  gateway_routes = [module.vpc.internet_gateway_id]
  ingress_rules = [
    {
      from        = 3000
      to          = 3000
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

// 内部APIを稼動させるコンテナ
module "inner_api_container" {
  source              = "./ECS"
  name                = "SlotSNSInnerAPI"
  vpc_id              = module.vpc.vpc_id
  subnets             = [module.vpc.private_subnets[1].id, module.vpc.public_subnets[0].id]
  task_definition_arn = module.inner_api_task_definition.arn
  security_groups     = [module.inner_api_sg.id]
  key_name            = var.key_name
  container_name      = "InnerAPI"
  container_port      = 3000
}
