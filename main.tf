# resource "aws_security_group" "web_sg" {
#   name        = "web security group"
#   description = "Allow TCP inbound traffic"
#   # tier_name   = "web"
#   vpc_id      = var.vpc_id
#   tags        = merge(
#     var.resource_tags,
#     {
#       Name = "${var.aws_region}-${var.resource_tags["Project"]}-web-sg"
#     }
#   )
  

# # Inbound rule for SSH (port 22)
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Inbound rule for HTTP (port 80)
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Inbound rule for HTTPS (port 443)
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Outbound rule to allow all traffic (optional, can be adjusted based on your needs)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"  # All protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }

# resource "aws_security_group" "app_sg" {
#   name        = "app security group"
#   description = "Allow TCP inbound traffic from the web sg"
#   vpc_id      = var.vpc_id
#   tags        = merge(
#     var.resource_tags,
#     {
#       Name = "${var.aws_region}-${var.resource_tags["Project"]}-app-sg"
#     }
#   )

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"  # All protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


# resource "aws_security_group_rule" "allow_web_to_app" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   security_group_id = aws_security_group.app_sg.id
#   source_security_group_id = aws_security_group.web_sg.id
# }




resource "aws_security_group" "security_group" {
  name        = "${var.tier_name}-security group"
  description = "Security group for the ${var.tier_name}"
  vpc_id      = var.vpc_id
  tags        = merge(
    var.resource_tags,
    {
      Name = "${var.aws_region}-${var.resource_tags["Project"]}-${var.tier_name}-sg"
    }
  )

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.source_security_group_id
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

