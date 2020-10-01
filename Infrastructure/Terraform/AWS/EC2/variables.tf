variable "name" {
  default     = "aws_project"
  description = "名前"
}

variable "subnet" {
  default     = ""
  description = "サブネット"
}

variable "security_groups" {
  default     = []
  description = "セキュリティグループIDの配列"
}

variable "ami" {
  default     = "ami-0cc75a8978fbbc969"
  description = "AMI"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "インスタンスタイプ"
}

variable "associate_public_ip_address" {
  default     = true
  description = "パブリックＩＰアドレスを割り振るか？"
}

variable "user_data" {
  default     = ""
  description = "ユーザデータ"
}

variable "key_name" {
  default     = ""
  description = "キー名"
}
