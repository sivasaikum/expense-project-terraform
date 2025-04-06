module "alb" {
  source = "terraform-aws-modules/alb/aws"
  
  internal = true
  #expense-dev-app-alb
  name = "${var.project}-${var.environment}-app-alb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  subnets = local.private_subnet_id
  create_security_group = false
  security_groups = [local.app_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project}-${var.environment}-app-alb"
    }
  )

}