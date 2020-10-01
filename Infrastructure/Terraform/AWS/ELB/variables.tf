variable "name" {
    default = "ELB"
    description = "名前"
}

variable "vpc_id" {
    description = "VPCのID"
}

variable "subnets" {
    description = "サブネットの配列"
}

variable "security_groups" {
    description = "セキュリティグループの配列"
}

variable "for_blue_green" {
    default = false
    description = "Blue/Greenデプロイ用か？"
}
