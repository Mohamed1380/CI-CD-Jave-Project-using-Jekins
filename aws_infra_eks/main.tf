module "vpc_module" {
  source          = "./modules/vpc"
  for_each        = var.vpc_config
  vpc_cider_block = each.value.vpc_cider_block
  tags            = each.value.tags
}

module "subnet_module" {
  source = "./modules/subnets"

  for_each = var.subnet_config

  cider_block       = each.value.cider_block
  tags              = each.value.tags
  vpc_id            = module.vpc_module[each.value.vpc_name].vpc_id
  availability_zone = each.value.availability_zone
}

module "internet_gateway_module" {
  source = "./modules/internet_gateway"
  for_each = var.IGW_config
  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id
  tags = each.value.tags
}

module "elasticIp_module" {

  for_each = var.elip_config
  source = "./modules/elastic_ip"
  tags = each.value.tags
}

module "natGateway_module" {
  source = "./modules/nat_gateway"
  for_each = var.natgateway_config
  allocation_id = module.elasticIp_module[each.value.allocation_id].elastic_ip
  subnet_id = module.subnet_module[each.value.subnet_id].subnet_id
  tags = each.value.tags
}

module "route_table_module" {
  source = "./modules/route_table"

  for_each = var.routetable_config
  igw_id = each.value.private == 0 ? module.internet_gateway_module[each.value.igw_id].igw_id : module.natGateway_module[each.value.igw_id].nat_id
  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id
  tags = each.value.tags
}

module "route_association_module" {
  source = "./modules/route_association"
  for_each = var.routerassociation_config
  route_table_id = module.route_table_module[each.value.route_table_id].route_table_id
  subnet_id = module.subnet_module[each.value.subnet_id].subnet_id
}

module "aws_eks" {
  source = "./modules/aws_eks"
  for_each = var.aws_eks_cluster_config
  eks_cluster_name = each.value.eks_cluster_name
  subnet_ids = [module.subnet_module[each.value.subnet1].subnet_id,module.subnet_module[each.value.subnet2].subnet_id,module.subnet_module[each.value.subnet3].subnet_id,module.subnet_module[each.value.subnet4].subnet_id,]
  tags = each.value.tags
  
}

module "aws_nodegroup" {
  source = "./modules/aws_nodegroup"
  for_each = var.aws_eks_nodegroup_config
  eks_cluster_name = module.aws_eks[each.value.eks_cluster_name].eks_cluster_name
  node_group_name = each.value.node_group_name
  subnet_ids = [module.subnet_module[each.value.subnet1].subnet_id,module.subnet_module[each.value.subnet2].subnet_id]
  tags = each.value.tags
  
}