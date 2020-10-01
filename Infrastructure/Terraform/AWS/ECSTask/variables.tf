variable "family" {
  default     = "Task"
  description = "family"
}

variable "cpu" {
  default     = 512
  description = "CPU"
}

variable "memory" {
  default     = 512
  description = "メモリ"
}

variable "container_memory" {
  default     = 128
  description = "コンテナのメモリ"
}

variable "container_name" {
  default     = "MyContainer"
  description = "コンテナ名"
}

variable "container_image" {
  description = "イメージ"
}

variable "container_port" {
  description = "コンテナ側のポート"
}

variable "host_port" {
  description = "ホスト側のポート"
}

variable "task_role_arn" {
  default     = ""
  description = "タスクロールのARN"
}

variable "execute_role_arn" {
  default     = ""
  description = "実行ロールのARN"
}

variable "environments" {
  default     = []
  description = "環境変数とその値の配列"
}
