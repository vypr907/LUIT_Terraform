# .tf file to hold all the network resources for my project

# creating the VPC
resource "aws_vpc" "hidden_pond" {
  cidr_block = var.apple_cidr

  tags = {
    Name        = "Hidden Pond VPC"
    Environment = "wk21proj"
  }
}

# creating the subnets within the VPC.
resource "aws_subnet" "private_subnet_alpha" {
  vpc_id            = aws_vpc.hidden_pond.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name        = "Private Subnet A"
    Environment = "wk21proj"
  }
}

resource "aws_subnet" "private_subnet_bravo" {
  vpc_id            = aws_vpc.hidden_pond.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name        = "Private Subnet B"
    Environment = "wk21proj"
  }
}