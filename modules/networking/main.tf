resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-${var.env}"
  }
}

# ---------- Internet Gateway ----------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.env}"
  }
}

# ---------- Public Subnet ----------

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone      = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${var.env}"
  }
}

# ---------- Private Subnet ----------

resource "aws_subnet" "private" {
  vpc_id             = aws_vpc.main.id
  cidr_block         = var.private_subnet_cidr
  availability_zone = var.az

  tags = {
    Name = "private-${var.env}"
  }
}

# ---------- Elastic IP for NAT ----------

resource "aws_eip" "nat" {
  domain = "vpc"
}

# ---------- NAT Gateway ----------

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat-${var.env}"
  }
}

# ---------- Public Route Table ----------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-public-${var.env}"
  }
}

# ---------- Private Route Table ----------

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-private-${var.env}"
  }
}

# ---------- Route Table Associations ----------

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# ---------- Public Security Group ----------

resource "aws_security_group" "public_sg" {
  name   = "public-sg-${var.env}"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg-${var.env}"
  }
}

# ---------- Private Security Group ----------

resource "aws_security_group" "private_sg" {
  name   = "private-sg-${var.env}"
  vpc_id = aws_vpc.main.id

  ingress {
    description     = "App traffic from public layer"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  ingress {
    description = "SSH from public subnet (bastion pattern)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg-${var.env}"
  }
}
