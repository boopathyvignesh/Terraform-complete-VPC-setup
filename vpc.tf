### creating VPC

resource "aws_vpc" "vpctf" {
  cidr_block = var.block0
  tags = {
    Name = "TFVPC"  #name reflect in VPC to identify easily
  }
}

### creating subnets

resource "aws_subnet" "Sub1" {
  vpc_id     = aws_vpc.vpctf.id
  cidr_block = var.block1
  availability_zone = "us-east-2a"
  map_public_ip_on_launch=true
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "Sub2" {
  vpc_id            = aws_vpc.vpctf.id
  availability_zone = "us-east-2b"
  cidr_block        = var.block2
  map_public_ip_on_launch=true
  tags = {
    Name = "subnet2"
  }
}
### creating internet gateway

resource "aws_internet_gateway" "vpctfigw" {
  vpc_id = aws_vpc.vpctf.id
  tags  = {
    Name = "VPC-TF-IGW"
  }
}

### route table

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpctf.id

  route {
    cidr_block = var.block3
    gateway_id = aws_internet_gateway.vpctfigw.id
  }
  tags = {
    Name = "routetab"
  }
}

### route table subnet association

resource "aws_route_table_association" "Subnet1" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.Sub1.id
  
}

resource "aws_route_table_association" "Subnet2" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.Sub2.id
  
}

### creating security group

resource "aws_security_group" "sgtf" {
  name        = "securitygroup"
  description = "Allow vpc cidr"
  vpc_id = aws_vpc.vpctf.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/20"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/20"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SecGroupforTF-VPC"
  }
}


