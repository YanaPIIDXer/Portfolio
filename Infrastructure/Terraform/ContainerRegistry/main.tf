provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

module "inner_api" {
  source          = "./ECR"
  repository_name = "inner_api"
}
