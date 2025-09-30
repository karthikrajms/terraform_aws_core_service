resource "aws_iam_user" "agitask02_user" {
  name = var.user_name
  tags = var.tags
}

# IAM Policy
resource "aws_iam_policy" "agitask02_policy" {
  name        = var.policy_name
  description = var.policy_description
  policy      = var.policy_document
  tags        = var.tags
}

# IAM Role
resource "aws_iam_role" "agitask02_role" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "agitask02_role_attach" {
  role       = aws_iam_role.agitask02_role.name
  policy_arn = aws_iam_policy.agitask02_policy.arn
}

# Attach policy to user
resource "aws_iam_user_policy_attachment" "agitask02_user_attach" {
  user       = aws_iam_user.agitask02_user.name
  policy_arn = aws_iam_policy.agitask02_policy.arn
}

variable "user_name" {
  description = "The name of the IAM user."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "policy_name" {
  description = "Name of the IAM policy."
  type        = string
  default     = "agitask02-policy"
}

variable "policy_description" {
  description = "Description of the IAM policy."
  type        = string
  default     = "Policy for agitask02"
}

variable "policy_document" {
  description = "IAM policy document (JSON)."
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:DescribeInstances",
      "Resource": "*"
    }
  ]
}
EOF
}

variable "role_name" {
  description = "Name of the IAM role."
  type        = string
  default     = "agitask02-role"
}

variable "assume_role_policy" {
  description = "Assume role policy document (JSON)."
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

output "user_name" {
  value = aws_iam_user.agitask02_user.name
}

output "role_name" {
  value = aws_iam_role.agitask02_role.name
}

output "policy_arn" {
  value = aws_iam_policy.agitask02_policy.arn
}
 