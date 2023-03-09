variable "ami" {
  description = "ami of ec2 instance"
  type        = string
}

variable "instanceType" {
  description = "Instance type of ec2"
  type        = string
  default     = "t2.micro"
}

variable "key-name" {
  description = "Private key of the ec2"
  type        = string
}

variable "buildID" {
  description = "Jenkins build ID"
  type        = string
}
