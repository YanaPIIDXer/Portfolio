variable "image_name" {}

resource "aws_ecr_repository" "default" {
  name = var.image_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "image_name" {
    value = var.image_name
}
