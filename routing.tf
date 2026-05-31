resource "aws_internet_gateway" "gateway" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet gateway"
  }
}

resource "aws_route_table" "tabla_de_routing" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "tabla routing"
  }
}

resource "aws_route_table_association" "asociacion_publica" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.tabla_de_routing.id
}