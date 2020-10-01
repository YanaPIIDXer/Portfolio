resource "aws_s3_bucket" "default" {
  bucket = var.bucket
  acl    = var.acl
}
