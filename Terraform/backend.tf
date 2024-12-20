terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-redis"   # Replace with your S3 bucket name
    key            = "terraform/terraform.tfstate"      # Path within the bucket
    region         = "ap-southeast-2"               # Replace with your AWS region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"         # Replace with your DynamoDB table name
  }
}