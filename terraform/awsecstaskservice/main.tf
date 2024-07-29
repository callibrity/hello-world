terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-awsecstaskservice"
    key            = "awsecstaskservice/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "awsbase" {
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket-awsbase"
    key    = "awsbase/terraform.tfstate"
    region = "us-east-2"
  }
}

# Task Definition
resource "aws_ecs_task_definition" "TD" {
  family                   = "nginx"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.terraform_remote_state.awsbase.outputs.iam_role_arn
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

# Service
resource "aws_ecs_service" "ECS-Service" {
  name                               = "my-service"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = data.terraform_remote_state.awsbase.outputs.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.TD.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  depends_on                         = [data.terraform_remote_state.awsbase.outputs.lb_listener, data.terraform_remote_state.awsbase.outputs.iam_role]


  load_balancer {
    target_group_arn = data.terraform_remote_state.awsbase.outputs.tg_arn
    container_name   = "main-container"
    container_port   = 8080
  }


  network_configuration {
    assign_public_ip = true
    security_groups  = [data.terraform_remote_state.awsbase.outputs.sg_id]
    subnets          = [data.terraform_remote_state.awsbase.outputs.subnet_1_id, data.terraform_remote_state.awsbase.outputs.subnet_2_id, data.terraform_remote_state.awsbase.outputs.subnet_3_id]
  }
}
