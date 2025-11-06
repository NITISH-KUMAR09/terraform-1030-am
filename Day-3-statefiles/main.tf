
resource "aws_instance" "name" {
     ami = "ami-01760eea5c574eb86"  
     instance_type = "t2.micro"
            
  tags = {
    Name = "prod"
  }
}
 resource "aws_s3_bucket" "name" {
    bucket = "bucket-1"
   
 }
 resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
   
 }
