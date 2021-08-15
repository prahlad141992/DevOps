#sample file for new alb.tf

resource "aws_lb" "alb_front" {
	name		       =	"ECSfront-alb-${var.uniqueflagvalue}"
	#internal	       =	true
  internal	       =	false
    load_balancer_type = "application"
    #security_groups = ["${aws_security_group.default.id}","${aws_security_group.selfreferencing.id}"]
    security_groups    = "${var.security_groups}"
	#subnets		      =	"${concat("${var.subnets}",["${var.albextrasubnet}"])}"
    subnets		       =	"${var.subnets}"
    tags = merge({
      "Name"        = format("%s", var.ecs_cluster)
      "Description" = "EC2ContainerService - ${var.ecs_cluster}"
      "uniquebatch" = format("%s", var.uniqueflagvalue)
      },
      var.tags
    )
#	enable_deletion_protection	=	true
# consider this for production
}

resource "aws_lb_target_group" "alb_front_https" {
	name	          = "ECSalb-front-https-${var.uniqueflagvalue}"
	vpc_id	        = "${var.vpc_id}"
	port	          = "80"
	protocol	      = "HTTP"
  tags = merge({
      "Name"        = format("%s", var.ecs_cluster)
      "Description" = "EC2ContainerService - ${var.ecs_cluster}"
      "uniquebatch" = format("%s", var.uniqueflagvalue)
      },
      var.tags
    )
	health_check {
                #path                = "/login"
                #port                = "8080"
                path                = "/"
                port                = "80"
                protocol            = "HTTP"
                healthy_threshold   = 2
                unhealthy_threshold = 2
                interval            = 5
                timeout             = 4
                matcher             = "200-308"
        }
}

resource "aws_lb_listener" "alb_front_https" {
	load_balancer_arn	  =	"${aws_lb.alb_front.arn}"
	#port			          =	"443"
	#protocol		        =	"HTTPS"
    port			          =	"80"
	protocol		        =	"HTTP"
    #ssl_policy		      =	"ELBSecurityPolicy-2016-08"
	#certificate_arn		  =	"${var.certificate_arn}"
	default_action {
		target_group_arn	=	"${aws_lb_target_group.alb_front_https.arn}"
		type			        =	"forward"
	}
}

# attempt to redirect 80 requests to https 443
#resource "aws_lb_listener" "front_end_redirect" {
 # load_balancer_arn = "${aws_lb.alb_front.arn}"
  #port              = "80"
  #protocol          = "HTTP"

  #default_action {
   # type            = "redirect"	

    #redirect {
     # port        = "443"
      #protocol    = "HTTPS"
      #status_code = "HTTP_301"
    #}
  #}
 # }