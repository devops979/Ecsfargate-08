resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-route-table"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = var.subnet_cidr_block_1
  availability_zone = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = "demo-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.demo_vpc.id
  cidr_block        = var.subnet_cidr_block_2
  availability_zone = var.availability_zone_2
  map_public_ip_on_launch = true
  tags = {
    Name = "demo-public-subnet-2"
  }
}

resource "aws_route_table_association" "route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "ecs_service_sg" {
  vpc_id = aws_vpc.demo_vpc.id
  name   = "ecs-service-sg"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  vpc_id      = aws_vpc.demo_vpc.id
  description = "Allow inbound HTTP traffic to the Load Balancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
