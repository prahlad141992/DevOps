# launch configuration
#For now we only use the AWS ECS optimized ami <https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html>
data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
    name                        = "EC2ContainerService-${var.ecs_cluster}-EcsInstanceLc-${random_id.fakeuuid.hex}"
    image_id                    =  data.aws_ami.amazon_linux_ecs.id
    instance_type               = "${var.instance_type}"
    iam_instance_profile        = "${var.role_name}"

    root_block_device {
      volume_type = "gp2"
      volume_size = "${var.volume_size}"
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = "${var.security_groups}"
    associate_public_ip_address = "true"
    key_name                    = "${var.key_name}"
    user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.ecs_cluster}-${var.uniqueflagvalue} >> /etc/ecs/ecs.config
                                  EOF
}

resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "EC2ContainerService-${var.ecs_cluster}-EcsInstanceAsg-${random_id.fakeuuid.hex}"
    max_size                    = "${var.max_instance_size}"
    min_size                    = "${var.min_instance_size}"
    desired_capacity            = "${var.desired_capacity}"
    #vpc_zone_identifier         = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]
    #vpc_zone_identifier         = ["subnet-060586d9be5b6ed9e", "subnet-0ac1fb98cb711c23b"]
    vpc_zone_identifier         = "${var.subnets}"
    launch_configuration        = "${aws_launch_configuration.ecs-launch-configuration.name}"
    health_check_type           = "EC2"
    tags = [
    {
      key                 = "Name"
      value               = "ECS Instance - EC2ContainerService-${var.ecs_cluster}"
      propagate_at_launch = true
    },
    {
      key                 = "Description"
      value               = "This instance is the part of the Auto Scaling group which was created through ${var.ecs_cluster} Cluster"
      propagate_at_launch = true
    },
    {
      key                 = "uniquebatch"
      value               = "${var.uniqueflagvalue}"
      propagate_at_launch = true
    },
  ]
  
  }