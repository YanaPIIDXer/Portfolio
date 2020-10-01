variable "name" {
  default     = "aws_project"
  description = "リソース名"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "ＩＰアドレスの範囲"
}

variable "public_subnets" {
  default = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = ""
    }
  ]
  description = "パブリックサブネットの配列。１つでも要素があればインターネットゲートウェイも生成する。"
}

variable "private_subnets" {
  default     = []
  description = "プライベートサブネットの配列"
}
