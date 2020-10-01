variable "name" {
  description = "名前"
}

variable "cluster_name" {
  description = "クラスタ名"
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

variable "container_name" {
  description = "コンテナ名"
}

variable "container_port" {
  description = "コンテナポート番号"
}

