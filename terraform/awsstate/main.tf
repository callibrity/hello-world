terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state_awsbase" {
  bucket = "terraform-state-bucket-awsbase"

  tags = {
    Name = "Terraform State Bucket - AWS Base"
  }
}

resource "aws_s3_bucket" "terraform_state_awsecstaskservice" {
  bucket = "terraform-state-bucket-awsecstaskservice"

  tags = {
    Name = "Terraform State Bucket - AWS Service"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}
