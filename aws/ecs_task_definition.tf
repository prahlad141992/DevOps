variable "create_tasks" {
  description = "Controls if task should be created"
  type        = bool
  default     = true
}

#variable "ecs_tasks" {
 # description = "Map of variables to define an ECS task."
  #type = map(object({
   # family               = string
    #container_definition = string
    #cpu                  = string
    #memory               = string
    #container_port       = string
  #}))
#}

variable "ecs_tasks" {
  description = "Map of variables to define an ECS task."
  type = map(object({
    family               = string
    container_definition = string
    cpu                  = string
    memory               = string
  }))
}

variable "task_definition_network_mode" {
  description = "Choose task definition network mode ex: default, Bridge, awsvpc"
  type        = string
  default     = "bridge"
}

variable "ecs_launch_type" {
  description = "Choose task definition ecs_launch_type ex: FARGATE or EC2"
  type        = string
  default     = "EC2"
}

#variable "extra_template_variables" {
 #description = "Choose task definition extra_template_variables"
 
# }

#variable "docker_image" {
 # description = "Controls if task should be created"
  #type        = string
  #default     = "prahlad141992/sloopaweb"
#}

#variable "docker_tag" {
 # description = "Controls if task should be created"
  #type        = string
  #default     = "latest"
#}
 # Create ECS Task Definition resources.
resource "aws_ecs_task_definition" "ecs_tasks" {
  for_each = var.create_tasks == true ? var.ecs_tasks : {}
  family   = each.value["family"]
  container_definitions = file(each.value["container_definition"])
  #container_definitions = templatefile(each.value["container_definition"], "${merge("${var.extra_template_variables}",
   # {
    #  container_name        = each.value["family"],
     # docker_image          = "${var.docker_image}:${var.docker_tag}",
      #aws_logs_group        = "/aws/ECSLogs/${aws_ecs_cluster.cluster.name}/${each.value["family"]}/${var.uniqueflagvalue}",
      #aws_log_stream_prefix = each.value["family"],
      #aws_region            = var.aws_region,
      #container_port        = each.value["container_port"]
  # })}")

  #task_role_arn            = aws_iam_role.ecs_task_role.arn
  task_role_arn            = "arn:aws:iam::806483491539:role/ecsTaskExecutionRole"
  network_mode             = var.task_definition_network_mode
  # CPU and memory are optional if you are using Launch_type as EC2.
  #cpu                      = each.value["cpu"]
  #memory                   = each.value["memory"]
  requires_compatibilities = [var.ecs_launch_type == "EC2" ? var.ecs_launch_type : "FARGATE"]
  #aws_iam_role.ecs_execution_role.arn
  execution_role_arn       = "arn:aws:iam::806483491539:role/ecsTaskExecutionRole"

  tags = merge({
    "Name"        = "${each.value["family"]}-${var.uniqueflagvalue}"
    "Description" = "Task definition for ${each.value["family"]}"
    }, var.tags
  )

  # Testing out EFS volume mount to ECS container
  volume {
    name = "efs-html"

    efs_volume_configuration {
      file_system_id          = "fs-e6ca7152"
      root_directory          = "/home/jenkins_home"
      transit_encryption      = "ENABLED"
    }
  }	
  ### end volume conf
}