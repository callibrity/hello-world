variable "ecs_cluster_id" {}
variable "iam_role" {}
variable "lb_listener" {}
variable "tg_arn" {}
variable "sg_id" {}
variable "subnet_1_id" {}
variable "subnet_2_id" {}
variable "subnet_3_id" {}

resource "aws_ecs_service" "ECS-Service" {
  name                               = "my-service"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.TD.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  depends_on                         = [var.lb_listener, var.iam_role]


  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "main-container"
    container_port   = 8080
  }


  network_configuration {
    assign_public_ip = true
    security_groups  = [var.sg_id]
    subnets          = [var.subnet_1_id, var.subnet_2_id, var.subnet_3_id]
  }
}