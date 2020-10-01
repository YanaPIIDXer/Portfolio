variable "name" {
  default     = "aws_project"
  description = "名前"
}

variable "vpc_id" {
  description = "ＶＰＣのＩＤ"
}

variable "gateway_routes" {
  default     = []
  description = "ゲートウェイとcidr_blockのセットの配列"
}

variable "ingress_rules" {
  default     = []
  description = "インバウンドルールの配列"
}

variable "egress_rules" {
  default = [
    {
      from        = 0
      to          = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  description = "アウトバウンドルールの配列"
}

// ↓「シンプルさ」を担保するための定義。
//  こいつらをtrueにしてやることで、それぞれの最低限なルール定義を有効にする。
//  例：enable_sshをtrueにすると、インバウンドルールとして
//          ・ポート：22
//          ・cidr_block：0.0.0.0/0
//      が追加される。
//      「cidr_blockを絞りたい」等の細かい設定がしたいならingress_rulesに記述する事。

variable "enable_ssh" {
  default     = false
  description = "SSH接続を有効にするか？"
}

variable "enable_http" {
  default     = false
  description = "HTTP接続を有効にするか？"
}

variable "enable_mysql" {
  default     = false
  description = "MySQL接続を有効にするか？"
}
