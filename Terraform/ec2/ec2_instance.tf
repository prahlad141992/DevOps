provider "aws" {
    region = "us-east-1"
}


resource  "aws_instance" "web01" {
  ami    = "ami-0bcc094591f354be2"
  instance_type = "t2.micro"

  tags = {
    Name = "firstec2terraform"
  }
}

