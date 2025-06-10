resource "aws_security_group" "demo_sg" {
  name        = "${var.name_prefix}-${terraform.workspace}-sg"
  description = "Security group for Task definition"
  vpc_id      = aws_vpc.demo-vpc.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs_fargate-sg"
  })
}


# For demo_sg
resource "aws_security_group_rule" "ecs_egress_demo" {
  security_group_id = aws_security_group.demo_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ecs_ingress_demo" {
  for_each = { for rule in var.ingress_rules : rule.name => rule }

  security_group_id = aws_security_group.demo_sg.id
  type              = "ingress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.name_prefix}-${terraform.workspace}-sg"
  description = "Security group for LoadBalancer"
  vpc_id      = aws_vpc.demo-vpc.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-alb-sg"
  })
}



# For alb_sg
resource "aws_security_group_rule" "ecs_egress_alb" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ecs_ingress_alb" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  description       = "Allowing load balancer port"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
