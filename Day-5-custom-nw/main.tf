#create vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name="custom-vpc"
    }
  
}
#create subnet
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      name="custom-subnet-1"
    }
  
}
#create subnet
resource "aws_subnet" "name-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      name="custom-subnet-2"
    }
  
}
#create IG and attach vpc
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
  
}
#create route table and eit routes
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id


    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
    
  
}
#create subnet association
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
  
}
#create sG
resource "aws_security_group" "name"{
    vpc_id  = aws_vpc.name.id
    tags ={
        name="dev-sg"
    }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
}
#create servers
resource "aws_instance" "public" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name-2.id
    vpc_security_group_ids = [ aws_security_group.name.dev-dg,id ]
    associate_public_ip_address = true
    tags = {
      name="public-ec2"
    }
  
}
resource "aws_instance" "private" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name-2.id
    vpc_security_group_ids = [ aws_security_group.name.dev-dg,id ]
    associate_public_ip_address = true
    tags = {
      name="private-ec2"
    }
}
#create EIP
resource "aws_eip" "nat_eip" {
 
  tags = {
    Name = "nat-eip"
  }
}

#create nat
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.name-1.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "nat-gateway"
  }
}

#create route and 
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "private-rt"
  }
}
#edits route
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
  
#route association
resource "aws_route_table_association" "private_assoc" {
 subnet_id = aws_subnet.name-2.id
  route_table_id = aws_route_table.private_rt.id
}