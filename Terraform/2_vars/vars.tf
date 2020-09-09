variable "aws_region" {
  default = "us-east-1"
}

variable "amiid" {
  type = map
  default = {
    us-east-1 = "ami-0ff8a91507f77f867"
    us-east-2 = "ami-0bbe28eb2173f6167"
  }
}



