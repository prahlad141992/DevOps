resource "aws_elb" "webelb" {
  name               = "web-elb"
#  availability_zones = ["us-east-1a", "us-east-1b"]
  subnets = [aws_subnet.terra-pub-1.id,aws_subnet.terra-pub-2.id]
  security_groups = [aws_security_group.elb-web-sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.web01.id,aws_instance.web02.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "web-elb"
  }
}



