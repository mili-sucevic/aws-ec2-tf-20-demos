# EC2 BASTION MODULE
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.1"

  name = "${var.environment}-bastion-host"

  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  user_data = file("${path.module}/jumpbox-install.sh") 

  tags = local.common_tags
}