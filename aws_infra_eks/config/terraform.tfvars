region = "us-east-1"

vpc_config = {
    vpc01 = {
        vpc_cider_block = "10.0.0.0/16"
        tags = {
            "Name" = "devops_vpc"
        }
    }
}

subnet_config = {

    "public-us-east-1a" = {
        vpc_name = "vpc01"
        cider_block = "10.0.1.0/24"
        availability_zone = "us-east-1a"
        tags = {
            "Name" = "public-us-east-1a"
        }
    }

    "public-us-east-1b" = {
        vpc_name = "vpc01"
        cider_block = "10.0.2.0/24"
        availability_zone = "us-east-1b"
        tags = {
            "Name" = "public-us-east-1b"
        }
    }

    "private-us-east-1a" = {
        vpc_name = "vpc01"
        cider_block = "10.0.3.0/24"
        availability_zone = "us-east-1a"
        tags = {
            "Name" = "private-us-east-1a"
        }
    }

    "private-us-east-1b" = {
        vpc_name = "vpc01"
        cider_block = "10.0.4.0/24"
        availability_zone = "us-east-1b"
        tags = {
            "Name" = "private-us-east-1b"
        }
    }
}

IGW_config = {

    igw1 = {
        vpc_name = "vpc01"
        tags = {
            Name = "igw"
        }
    }
}

elip_config = {

    elip1 = {
        tags = {
            "Name" = "elip1"
        }
    }

    elip2 = {
        tags = {
            "Name" = "elip2"
        }
    }
}

natgateway_config = {

    nat01 = {
        allocation_id = "elip1"
        subnet_id = "public-us-east-1a"
        tags = {
            "Name" = "nat1"
        }
    }

    nat02 = {
        allocation_id = "elip2"
        subnet_id = "public-us-east-1b"
        tags = {
            "Name" = "nat2"
        }
    }
}

routetable_config = {
    RT01 = {
        private = 0
        vpc_name = "vpc01"
        igw_id = "igw1"
        tags = {
            "Name" = "public_route"
        }
    }

    RT02 = {
        private = 1 
        vpc_name = "vpc01"
        igw_id = "nat01"
        tags = {
            "Name" = "private_route1"
        }
    }

    RT03 = {
        private = 1
        vpc_name = "vpc01"
        igw_id = "nat02"
        tags = {
            "Name" = "private_route2"
        }
    }
}

routerassociation_config = {
    RT01Ass ={
        subnet_id = "public-us-east-1a"
        route_table_id = "RT01"
    }

    RT02Ass ={
        subnet_id = "public-us-east-1b"
        route_table_id = "RT01"
    }

    RT03Ass ={
        subnet_id = "private-us-east-1a"
        route_table_id = "RT02"
    }

    RT04Ass ={
        subnet_id = "private-us-east-1b"
        route_table_id = "RT03"
    }

}
aws_eks_cluster_config = {
    "demo-eks" = {
        eks_cluster_name = "demo-cluster"
        subnet1 = "public-us-east-1a"
        subnet2 = "public-us-east-1b"
        subnet3 = "private-us-east-1a"
        subnet4 = "private-us-east-1b"

        tags = {
            "Name" = "demo-cluster"
        }
    }
}

aws_eks_nodegroup_config = {
    node1 = {
        
        node_group_name= "node-group-1"
        eks_cluster_name = "demo-eks"
        subnet1 = "private-us-east-1a"
        subnet2 = "private-us-east-1b"

        tags = {
            "Name" = "node-1"
        }
    }

    node2 = {
        
        node_group_name= "node-group-2"
        eks_cluster_name = "demo-eks"
        subnet1 = "private-us-east-1a"
        subnet2 = "private-us-east-1b"

        tags = {
            "Name" = "node-2"
        }
    }
}