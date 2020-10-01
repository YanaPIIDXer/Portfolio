variable "name" {
  default     = "ECS"
  description = "名前"
}

variable "task_definition_arn" {
  description = "タスク定義のARN"
}

variable "vpc_id" {
  description = "VPCのID"
}

variable "subnets" {
  description = "サブネットの配列"
}

variable "security_groups" {
  default     = []
  description = "セキュリティグループ配列"
}

variable "ami" {
  default     = "ami-0b229fb8956ace6cd"
  description = "起動するEC2インスタンスのAMI"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "起動するEC2インスタンスのインスタンスタイプ"
}

variable "key_name" {
  default     = ""
  description = "keyの名前"
}

variable "container_name" {
  default     = "ECS_LB_Container"
  description = "コンテナ名"
}

variable "container_port" {
  default = 80
  description = "コンテナポート番号"
}
