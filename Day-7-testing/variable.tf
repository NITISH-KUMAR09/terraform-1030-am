variable "ami_id" {
    type = string
  
}
variable "type" {
    description = "passing values to instance type "
    default = "t3.micro"
    type = string
}