resource "aws_instance" "backend" {
    ami             = data.aws_ami.devops-practice.id
    instance_type   = "t3.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
    subnet_id   = local.private_subnet_id
    tags = merge (
        var.common_tags,
        {
            Name = "${var.project}-${var.environment}-backend"
        }
    )
}