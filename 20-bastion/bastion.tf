resource "aws_instance" "bastion" {
    ami             = data.aws_ami.devops-practice.id
    instance_type   = "t3.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    subnet_id   = local.public_subnet_id
    tags = merge (
        var.common_tags,
        {
            Name = "${var.project}-${var.environment}-bastion"
        }
    )
}