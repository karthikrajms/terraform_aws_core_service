resource "aws_instance" "agitask02_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = merge({
    Name = var.instance_name
  }, var.tags)
}

variable "ami" {
  description = "AMI to use for the instance."
  type        = string
  default     = "ami-06a974f9b8a97ecf2"
}

variable "instance_type" {
  description = "Type of instance."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the instance."
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance."
  type        = string
  
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instance."
  type        = list(string)
}

output "instance_id" {
  value = aws_instance.agitask02_instance.id
}
