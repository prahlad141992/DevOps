variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "amiid" {
  description = "select the ami id to deploy ec2 instanace "
  default = "ami-0bcc094591f354be2"
}
