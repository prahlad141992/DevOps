variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
}

variable "subnet_id" {
  description = "Subnet to launch servers."
# Do not define this, so that all scripts can be caught that do not yet
# default     = "Not Defined"
}

variable "albextrasubnet" {
  description = "Additional subnet to use for ALB"
# Do not define this, so that all scripts can be caught that do not yet
# default     = "Not Defined"
}

variable "subnets" {
#  description = "array of subnets to use for AZs and hopefully instances"
#  complains about multiple subnets in same AZ
  type        = list(string)
#  default     = ["subnet-c65452a3","subnet-ea33ebb0" ]
}

variable "vpc_id" {
  description = "vpc to launch servers."
# Do not define this, so that all scripts can be caught that do not yet
# default     = "Not Defined"
}

variable "security_groups" {
#  description = "array of subnets to use for AZs and hopefully instances"
#  complains about multiple subnets in same AZ
  type        = list(string)
#  default     = ["subnet-c65452a3","subnet-ea33ebb0" ]
}


variable "ecs_cluster" {
  description = "Name to be used on all the resources as identifier, also the name of the ECS cluster"
  type        = string
  #default     = null
}

# note uniqueflagvalue and uniquevalueflag possible swap in deploy scripts
variable "uniqueflagvalue" {
  description = "Change this value to force regeneration of ELB.  Reuse existing value to maintain existing ELB possibly linked to DNS alias"
  type        = string
  #default     = null
}

variable "tags" {
  description = "A map of tags to add to ECS Cluster"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "Type for instance."
  default     = "t2.micro"
}

variable "volume_size" {
  description = "size of root volume"
  default     = "30"
}

variable "role_name" {
  description = "Amazon EC2 Container Service for EC2 Role"
  type        = string
  #default     = null
}

########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}

