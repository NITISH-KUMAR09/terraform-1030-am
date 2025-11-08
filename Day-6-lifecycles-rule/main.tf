resource "aws_instance" "name" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t3.micro"
    tags = {
      name="dev"
    }
    
    #lifecycle  {
   #create_before_destroy=true
    #}
    
    #lifecycle {
     # ignore_changes = [tags  ]
    #}

    lifecycle {
      prevent_destroy = true
    }

  }
