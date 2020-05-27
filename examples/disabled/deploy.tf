#####
# Provider
#####



#####
# Context
#####

#####
# EKS Node Goupe
#####

module "this" {
  source = "../../"

  enabled                       = false
  eks_node_group_count          = 0
  eks_cluster_name              = "disabled"
  eks_node_group_names          = []
  eks_node_group_node_role_arns = []
  eks_node_group_subnet_ids     = []
  eks_node_group_desired_sizes  = []
  eks_node_group_min_sizes      = []
  eks_node_group_max_sizes      = []
}
