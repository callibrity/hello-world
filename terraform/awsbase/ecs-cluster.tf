resource "aws_ecs_cluster" "ECS" {
  name = "my-cluster"

  tags = {
    Name = "my-new-cluster"
  }
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.ECS.id
}