variable "iam_role_arn" {}

resource "aws_ecs_task_definition" "TD" {
  family                   = "nginx"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.iam_role_arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "main-container"
      image     = "211125712788.dkr.ecr.us-east-2.amazonaws.com/hello-world:c513af022ddb905685fb5ec8628adb417cc44d50"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}


data "aws_ecs_task_definition" "TD" {
  task_definition = aws_ecs_task_definition.TD.family
}