variable "family" {}
variable "container_name" {}
variable "image" {}
variable "container_port" {}
variable "host_port" {}
variable "protocol" {}
variable "cpu" {
    default = "256"
}

variable "memory" {
    default = "512"
}
