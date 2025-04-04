module "vpc" {
    #source = "../terraform-aws-vpc"

    source = "git::https://github.com/sivasaikum/terraform-aws-vpc.git?ref=main"
    cidr_block = var.cidr_block
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    vpc_tags = var.vpc_tags
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    database_subnet_tags = var.database_subnet_tags
    is_peering_required = true
}