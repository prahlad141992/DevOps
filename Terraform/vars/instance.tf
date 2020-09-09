provider "aws" {
    region = var.aws_region
}


resource  "aws_instance" "web01" {
  ami    = var.amiid
  instance_type = "t2.micro"

  tags = {
    Name = "terraformvars"
  }
}

