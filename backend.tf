terraform {
  backend "s3" {
    bucket         = "demolbecsapi"
    key            = "uscs2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "ecsfrgt"
  }
}
