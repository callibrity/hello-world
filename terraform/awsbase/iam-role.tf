resource "aws_iam_role" "iam-role" {
  name               = "ECS-execution-role"
  assume_role_policy = file("${path.module}/iam-role.json")
}

output "iam_role_arn" {
  value = aws_iam_role.iam-role.arn
}

output "iam_role" {
  value = aws_iam_role.iam-role
}