provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

module "SSHServer" {
  source = "./SSHServer"
  ami_id = "ami-066b76d09a3d3ff4e"
  tags_name = "SSHServer"
}
