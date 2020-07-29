variable "VPC_AvailabilityZone" {
    default = "ap-northeast-1a"
}

resource "aws_vpc" "SlotSNS_VPC" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "false"
    tags = {
      Name = "SlotSNS_VPC"
    }
}

resource "aws_internet_gateway" "SlotSNS_InternetGateway" {
    vpc_id = aws_vpc.SlotSNS_VPC.id
}

resource "aws_subnet" "SlotSNS_Subnet_Public" {
    vpc_id = aws_vpc.SlotSNS_VPC.id
    cidr_block = "10.0.0.2/24"
    availability_zone = var.VPC_AvailabilityZone
}
