terraform {
  backend "s3" {
    bucket = "aws-base-state-bucket"
    key    = "awsbase/terraform.tfstate"
    region = "us-east-2"
  }
}