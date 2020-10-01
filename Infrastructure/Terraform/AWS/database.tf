// データベースのセキュリティグループ
module "database_sg" {
  source = "./SecurityGroup"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  gateway_routes = [module.vpc.internet_gateway_id]
  enable_mysql = true
}

// データベース
// FIXME:作業終了と同時にリソースを撤去すると全てのデータが吹っ飛ぶ。
//       State機能使えない・・・？（調べた事が無いのでどのような機能なのか分からない。）
module "database" {
  source     = "./RDS"
  name       = "slot-sns"
  identifier = "slot-sns"
  subnets    = [module.vpc.private_subnets[0].id, module.vpc.private_subnets[1].id]
  root_data = {
    name     = "root"
    password = "root"
  }
  security_groups = [module.database_sg.id]
}
