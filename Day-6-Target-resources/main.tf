resource "aws_instance" "name" {
  ami = "ami-01760eea5c574eb86"
  instance_type = "t3.micro"
  availability_zone = "ap-south-1a"
  tags = {
    name="dev"
  }
}
resource "aws_s3_bucket" "name" {
    bucket = "bucket-1"
   
 }
 # target resource can we user to apply specific resource only below command is the reference
 #terraform apply-target=aws_s3_bucket.name