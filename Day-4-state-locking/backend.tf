terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "terraform.tfstate"
    #use_lockfile = true # to use s3 native locking
    region = "us-east-1"
    dynamodb_table = "Nitish"
    encrypt = true
  }
}
