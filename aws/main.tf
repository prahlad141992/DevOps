# Specify the provider and other required details
provider "aws" {
  region    = "${var.aws_region}"
 
}

terraform {
  required_providers {
    aws = {
      #source  = "hashicorp/aws"
      version = ">=3.42.0"
    }
  }
  #use S3 bucket for state.
  backend "s3" { 
      bucket = "ps-ecs-cluster"
      key    = "terraform/ecs_cluster_state"
      region = "us-east-1"
      workspace_key_prefix = "tf-workspace-state"
    }
}

#### Create ECS Cluster ##############
resource "aws_ecs_cluster" "cluster" {
  
  name = "${var.ecs_cluster}-${var.uniqueflagvalue}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge({
      "Name"        = format("%s", var.ecs_cluster)
      "Description" = "EC2ContainerService - ${var.ecs_cluster}"
      "uniquebatch" = format("%s", var.uniqueflagvalue)
    },
    var.tags
  )
  
  }

resource "random_id" "fakeuuid" {
  keepers = {
    # Generate a new id each time only when new value is specified
    # This will allow reuse of ELBs and security groups unless
    # a new unique value variable is chosen.
    ami_id              = "${var.uniqueflagvalue}"
  }

  byte_length = 8
}