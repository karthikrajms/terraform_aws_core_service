resource "aws_vpc" "agitask02_vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}

resource "aws_subnet" "agitask02_subnet" {
  vpc_id                  = aws_vpc.agitask02_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true
  tags                    = var.tags
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet."
  type        = string
}

variable "az" {
  description = "Availability zone for the subnet."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

output "vpc_id" {
  value = aws_vpc.agitask02_vpc.id
}

output "subnet_id" {
  value = aws_subnet.agitask02_subnet.id
}

# Security Group
resource "aws_security_group" "agitask02_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.agitask02_vpc.id
  tags        = var.tags

  dynamic "ingress" {
    for_each = var.sg_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "sg_name" {
  description = "Name of the security group."
  type        = string
  default     = "agitask02-sg"
}

variable "sg_description" {
  description = "Description of the security group."
  type        = string
  default     = "Security group for agitask02"
}

variable "sg_ingress" {
  description = "List of ingress rules for the security group."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

output "security_group_id" {
  value = aws_security_group.agitask02_sg.id
}
