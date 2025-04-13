module "mysql_sg" {
    source = "git::https://github.com/sivasaikum/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "mysql"
    sg_desc = "creating a security group for mysql instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags

}

module "backend_sg" {
    source = "git::https://github.com/sivasaikum/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "backend"
    sg_desc = "creating a security group for backend instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags

}

module "frontend_sg" {
    source = "git::https://github.com/sivasaikum/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "frontend"
    sg_desc = "creating a security group for frontend instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags

}

module "bastion_sg" {
    source = "git::https://github.com/sivasaikum/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "bastion"
    sg_desc = "creating a security group for bastion instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags

}

module "app_alb_sg" {
    source = "git::https://github.com/sivasaikum/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "app-alb"
    sg_desc = "creating a security group for backend ALB in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags

}

module "vpn_sg" {
    source = "git::https://github.com/sivasaikum/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = "vpn"
    sg_desc = "creating a security group for VPN in expense dev"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags

}

# APP ALB is accepting traffic from bastion
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id      = module.bastion_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

resource "aws_security_group_rule" "vpn_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

resource "aws_security_group_rule" "vpn_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}