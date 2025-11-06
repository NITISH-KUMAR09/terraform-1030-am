resource "aws_instance" "name" {
  ami = "ami-01760eea5c574eb86"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.name.id
  tags = {
    name="dev"
  }
  
  
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_subnet" "name" {
   vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    
  
}