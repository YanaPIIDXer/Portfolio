variable "name" {
  default     = "aws_project"
  description = "名前"
}

variable "vpc_id" {
  description = "ＶＰＣのＩＤ"
}

variable "subnets" {
  default     = []
  description = "サブネットの配列"
}

variable "gateway_routes" {
  default     = []
  description = "ゲートウェイとcidr_blockのセットの配列"
}

variable "nat_gateway_routes" {
  default     = []
  description = "NATゲートウェイとcidr_blockのセットの配列"
}
