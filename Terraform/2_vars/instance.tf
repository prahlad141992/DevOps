provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "pluto" {
  ami = lookup(var.amiid, var.aws_region)
  instance_type = "t2.micro"
}

