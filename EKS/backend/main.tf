provider "aws" {
  region = "us-west-2"
  
}

resource "aws_s3_bucket" "example" { # when we call the resource, we will use the name "example"
    bucket = "my-tf-test-bucket"
    lifecycle {
        prevent_destroy = false
    }
  
}

resource "aws_dynamodb_table" "example" {
    name           = "my-table"
    billing_mode   = "PAY_PER_REQUEST"
    read_capacity  = 20
    write_capacity = 20
    hash_key       = "LockID"
    
    
    attribute {
        name = "LockID"
        type = "S"
    }
}



