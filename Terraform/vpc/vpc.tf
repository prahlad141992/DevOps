resource "aws_vpc" "terra-vpc" {
  cidr_block       = "172.20.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "terra-vpc"
  }
}

resource "aws_subnet" "terra-pub-1" {
  vpc_id     = aws_vpc.terra-vpc.id
  cidr_block = "172.20.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terra-pub-1"
  }
}
resource "aws_subnet" "terra-pub-2" {
  vpc_id     = aws_vpc.terra-vpc.id
  cidr_block = "172.20.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terra-pub-2"
  }
}
resource "aws_subnet" "terra-priv-1" {
  vpc_id     = aws_vpc.terra-vpc.id
  cidr_block = "172.20.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terra-priv-1"
  }
}
resource "aws_subnet" "terra-priv-2" {
  vpc_id     = aws_vpc.terra-vpc.id
  cidr_block = "172.20.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "terra-priv-2"
  }
}

resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.terra-vpc.id

  tags = {
    Name = "terra-igw"
  }
}

resource "aws_route_table" "terra-pub-rt" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id
  }

  tags = {
    Name = "terra-pub-rt"
  }
}

resource "aws_route_table_association" "terra-pub1-rt-as" {
  subnet_id      = aws_subnet.terra-pub-1.id
  route_table_id = aws_route_table.terra-pub-rt.id
}


resource "aws_route_table_association" "terra-pub2-rt-as" {
  subnet_id      = aws_subnet.terra-pub-2.id
  route_table_id = aws_route_table.terra-pub-rt.id
}

