resource "aws_subnet" "subnet_publica" {

    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

    tags = {
      Name = "Subnet Publica De La VPC"
    }
}

resource "aws_subnet" "subnet_privada" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "Subnet Privada De La VPC"
    }

}