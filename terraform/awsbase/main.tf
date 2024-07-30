terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.59.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-awsbase"
    key            = "awsbase/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}