variable "ami_id" {}
variable "tags_name" {}

resource "aws_instance" "SlotSNS_SSHServer" {
  ami           =  var.ami_id
  instance_type =  "t2.micro"

  tags = {
    Name = var.tags_name
  }
}