terraform {
  backend "s3" {
    bucket = "kops-state-440"
    key = "terraform/backendstate"
    region = "us-east-1"
  }
}
