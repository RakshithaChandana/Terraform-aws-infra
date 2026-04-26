provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ex_instance" {
  tags = {
    Name        = "terraform"
    Environment = "dev"
    Project     = "yum-cart"
  }
  ami                 = "ami-0ecb62995f68bb549"
  instance_type          = "t3.micro"
  subnet_id     = aws_subnet.subnet_1.id
  key_name               = "Seetharam"
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  count                  = 2
  root_block_device {
    volume_size = 12
  }
}

