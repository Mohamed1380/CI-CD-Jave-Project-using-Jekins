terraform {
  backend "s3" {
    bucket         = "abdelhady1"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "db-table"
  }
}