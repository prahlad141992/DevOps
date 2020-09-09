resource "aws_security_group" "myterra-sg" {
  name        = "myterra-sg"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
    
}

resource "aws_security_group" "elb-web-sg" {
  name        = "elb-web-sg"
  description = "Allow inbound traffic on port 80"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

}
