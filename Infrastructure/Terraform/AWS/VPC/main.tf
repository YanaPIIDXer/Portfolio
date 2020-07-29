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

resource "aws_route_table" "SlotSNS_RouteTable_Public" {
    vpc_id = aws_vpc.SlotSNS_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.SlotSNS_InternetGateway.id
    }
}

resource "aws_route_table_association" "SlotSNS_RouteTable_Association_Public" {
    subnet_id = aws_subnet.SlotSNS_Subnet_Public.id
    route_table_id = aws_route_table.SlotSNS_RouteTable_Public.id
}

resource "aws_security_group" "SlotSNS_SecurityGroup_Public" {
    name = "SlotSNS_SecurityGroup_Public"
    vpc_id = aws_vpc.SlotSNS_VPC.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
