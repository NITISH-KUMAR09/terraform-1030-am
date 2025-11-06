variable "ami_id" {
    type = string
  
}
variable "type" {
    description = "passing values to instance type "
    default = "t2.micro"
    type = string
}