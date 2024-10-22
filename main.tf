module "VPC" {
  source       = "./modules/VPC"
  pub_sub1_id  = module.Subnet.pub_sub1_id
  pub_sub2_id  = module.Subnet.pub_sub2_id
  priv_sub1_id = module.Subnet.priv_sub1_id
  priv_sub2_id = module.Subnet.priv_sub2_id
}

module "Subnet" {
  source   = "./modules/Subnet"
  myvpc_id = module.VPC.myvpc_id
}

module "EC2" {
  source          = "./modules/EC2"
  pub_sg_id       = module.VPC.pub_sg_id
  priv_sg_id      = module.VPC.priv_sg_id
  pub_sub1_id     = module.Subnet.pub_sub1_id
  pub_sub2_id     = module.Subnet.pub_sub2_id
  priv_sub1_id    = module.Subnet.priv_sub1_id
  priv_sub2_id    = module.Subnet.priv_sub2_id
  alb_private_dns = module.ALB.alb_private_dns
}


module "NLB" {
  source       = "./modules/NLB"
  myvpc_id     = module.VPC.myvpc_id
  priv_sg_id   = module.VPC.priv_sg_id
  pub_sub1_id  = module.Subnet.pub_sub1_id
  pub_sub2_id  = module.Subnet.pub_sub2_id
  nginx1_id    = module.EC2.nginx1_id
  nginx2_id    = module.EC2.nginx2_id

}

module "ALB" {
  source       = "./modules/ALB"
  myvpc_id     = module.VPC.myvpc_id
  pub_sg_id    = module.VPC.pub_sg_id
  priv_sub1_id = module.Subnet.priv_sub1_id
  priv_sub2_id = module.Subnet.priv_sub2_id
  web1_id      = module.EC2.web1_id
  web2_id      = module.EC2.web2_id
}