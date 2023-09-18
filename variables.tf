variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "resource_tags" {
    description = "Tags for your resources"
    type = map(string)
}

variable "aws_region" {
    description = "my default AWS Region"
    type = string
}

variable "tier_name" {
    description = "the resource attached to the security group"
    type = string
}


variable "ingress_rules" {
  description = "A list of ingress rules to apply to the security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    source_security_group_id = list(string)
  }))
}
