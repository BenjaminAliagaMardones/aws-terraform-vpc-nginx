resource "aws_instance" "server" {

  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"
  key_name      = "clave-servidor"

  vpc_security_group_ids = [aws_security_group.sg_servidor.id]
  subnet_id              = aws_subnet.subnet_publica.id

  user_data = file("${path.module}/setup.sh")
}

terraform {
  backend "s3" {
    bucket = "terraform-state-godiano"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}