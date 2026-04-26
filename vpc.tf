resource "aws_vpc" "vpc_1" {
  tags = {
    Name = "my-vpc"
  }
  cidr_block           = "20.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_1" {
  tags = {
    Name = "aws_subnet_1"
  }
  vpc_id                  = aws_vpc.vpc_1.id
  availability_zone       = "us-east-1c"
  cidr_block              = "20.0.1.0/24"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "subnet_2" {
  tags = {
    Name = "aws_subnet_2"
  }
  vpc_id                  = aws_vpc.vpc_1.id
  availability_zone       = "us-east-1b"
  cidr_block              = "20.0.3.0/24"
  map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "my-igw"
  }
  vpc_id = aws_vpc.vpc_1.id
}
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  tags = {
    Name = "my-nat-gateway"
  }
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet_2.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "my_route_table" {
  tags = {
    Name = "public_route_table"
  }
  vpc_id = aws_vpc.vpc_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "route_private" {
  tags = {
    Name = "private_route_table"
  }
  vpc_id = aws_vpc.vpc_1.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
}

resource "aws_route_table_association" "subnet_1c" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "subnet_1b" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_private.id
}

