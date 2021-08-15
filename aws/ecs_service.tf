variable "create_microservices" {
  description = "Controls if service should be created"
  type        = bool
  default     = true
}

variable "fargate_microservices" {
  description = "Map of variables to define a Fargate microservice."
  type = map(object({
    name                   = string
    task_definition        = string
    desired_count          = string
    launch_type            = string
  }))
}

resource "aws_ecs_service" "fargate-microservices" {
  for_each      = var.create_microservices == true ? var.fargate_microservices : {}
  name          = each.value["name"]
  cluster       = aws_ecs_cluster.cluster.id
  desired_count = each.value["desired_count"]
  launch_type   = each.value["launch_type"]
  depends_on = [aws_ecs_cluster.cluster,
  aws_ecs_task_definition.ecs_tasks]
  task_definition = each.value["task_definition"]

  #network_configuration {
   # subnets         = var.ecs_service_subnets
    #security_groups = [aws_security_group.ecs_security_groups[each.value["security_group_mapping"]].id]
  #}
  load_balancer {
        target_group_arn = "${aws_lb_target_group.alb_front_https.arn}"
    	  container_port    = 80
        container_name    = each.value["task_definition"]
        
	}
}
