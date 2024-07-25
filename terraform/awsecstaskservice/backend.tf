terraform {
  backend "s3" {
    bucket = "aws-service-state-bucket"
    key    = "awsecstaskservice/terraform.tfstate"
    region = "us-east-2"
  }
}