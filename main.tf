#####
# Locals
#####

locals {
  tags = {
    "Terraform"  = "true"
    "managed-by" = "terraform"
  }
  policy_arns = concat(
    [
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    ],
    var.additional_iam_policy_arns
  )
}

#####
# Datasources
#####

data "aws_iam_policy_document" "this" {
  count = var.enabled && var.create_iam_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#####
# IAM
#####

resource "aws_iam_role" "this" {
  count = var.enabled && var.create_iam_role ? 1 : 0

  name                  = var.iam_role_name
  name_prefix           = var.iam_role_name_prefix
  assume_role_policy    = element(concat(data.aws_iam_policy_document.this.*.json, list("")), 0)
  force_detach_policies = var.iam_role_force_detach_policies
  path                  = var.iam_role_path
  description           = var.iam_role_description
  max_session_duration  = var.iam_role_max_session_duration
  permissions_boundary  = var.iam_role_permissions_boundary
  tags = merge(
    local.tags,
    var.tags,
    var.iam_role_tags
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.enabled && var.create_iam_role ? length(local.policy_arns) : 0

  policy_arn = element(local.policy_arns, count.index)
  role       = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

#####
# EKS Node Group
#####

resource "aws_eks_node_group" "without_ignore_changes_on_desired_size" {
  count = var.enabled && false == ignore_changes_on_desired_size ? var.eks_node_group_count : 0

  cluster_name    = var.eks_cluster_name
  node_group_name = element(var.eks_node_group_names, count.index)
  node_role_arn   = var.create_iam_role ? element(concat(aws_iam_role.this.*.arn, list("")), 0) : element(var.eks_node_group_node_role_arns, count.index)
  subnet_ids      = element(var.subnet_ids, count.index)

  ami_type             = length(var.eks_node_group_ami_types) == var.eks_node_group_count ? element(var.eks_node_group_ami_types, count.index) : null
  disk_size            = length(var.eks_node_group_disk_sizes) == var.eks_node_group_count ? element(var.eks_node_group_disk_sizes, count.index) : null
  force_update_version = length(var.eks_node_group_force_update_versions) == var.eks_node_group_count ? element(var.eks_node_group_force_update_versions, count.index) : null
  instance_types       = length(ver.eks_node_group_instance_types) == var.eks_node_group_count ? element(var.eks_node_group_instance_types, count.index) : null
  labels               = length(ver.eks_node_group_labels) == var.eks_node_group_count ? element(var.eks_node_group_labels, count.index) : null
  release_version      = length(ver.eks_node_group_release_versions) == var.eks_node_group_count ? element(var.eks_node_group_release_versions, count.index) : null
  version              = length(ver.eks_node_group_versions) == var.eks_node_group_count ? element(var.eks_node_group_versions, count.index) : null

  tags = merge(
    local.tags,
    var.tags,
    var.eks_worker_group_tags,
    length(ver.eks_node_groups_tags) == var.eks_node_group_count ? element(var.eks_node_groups_tags, count.index) : {}
  )

  dynamic "remote_access" {
    for_each = length(var.eks_worker_group_remote_access_ec2_ssh_keys) == var.eks_node_group_count || length(var.eks_worker_group_remote_access_source_security_group_ids) == var.eks_node_group_count ? [1] : []

    content {
      ec2_ssh_key               = length(var.eks_worker_group_remote_access_ec2_ssh_keys) == var.eks_node_group_count ? element(var.eks_worker_group_remote_access_ec2_ssh_keys, count.index) : null
      source_security_group_ids = length(var.eks_worker_group_remote_access_ec2_ssh_keys) == var.eks_node_group_count ? element(var.eks_worker_group_remote_access_ec2_ssh_keys, count.index) : null
    }
  }

  scaling_config {
    desired_size = element(var.eks_node_group_desired_sizes, count.index)
    max_size     = element(var.eks_node_group_max_sizes, count.index)
    min_size     = element(var.eks_node_group_min_sizes, count.index)
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.this[0],
    aws_iam_role_policy_attachment.this[1],
    aws_iam_role_policy_attachment.this[2],
  ]
}

resource "aws_eks_node_group" "with_ignore_changes_on_desired_size" {
  count = var.enabled && ignore_changes_on_desired_size ? var.eks_node_group_count : 0

  cluster_name    = var.eks_cluster_name
  node_group_name = element(var.eks_node_group_names, count.index)
  node_role_arn   = var.create_iam_role ? element(concat(aws_iam_role.this.*.arn, list("")), 0) : element(var.eks_node_group_node_role_arns, count.index)
  subnet_ids      = element(var.subnet_ids, count.index)

  ami_type             = length(var.eks_node_group_ami_types) == var.eks_node_group_count ? element(var.eks_node_group_ami_types, count.index) : null
  disk_size            = length(var.eks_node_group_disk_sizes) == var.eks_node_group_count ? element(var.eks_node_group_disk_sizes, count.index) : null
  force_update_version = length(var.eks_node_group_force_update_versions) == var.eks_node_group_count ? element(var.eks_node_group_force_update_versions, count.index) : null
  instance_types       = length(ver.eks_node_group_instance_types) == var.eks_node_group_count ? element(var.eks_node_group_instance_types, count.index) : null
  labels               = length(ver.eks_node_group_labels) == var.eks_node_group_count ? element(var.eks_node_group_labels, count.index) : null
  release_version      = length(ver.eks_node_group_release_versions) == var.eks_node_group_count ? element(var.eks_node_group_release_versions, count.index) : null
  version              = length(ver.eks_node_group_versions) == var.eks_node_group_count ? element(var.eks_node_group_versions, count.index) : null

  tags = merge(
    local.tags,
    var.tags,
    var.eks_worker_group_tags,
    length(ver.eks_node_groups_tags) == var.eks_node_group_count ? element(var.eks_node_groups_tags, count.index) : {}
  )

  dynamic "remote_access" {
    for_each = length(var.eks_worker_group_remote_access_ec2_ssh_keys) == var.eks_node_group_count || length(var.eks_worker_group_remote_access_source_security_group_ids) == var.eks_node_group_count ? [1] : []

    content {
      ec2_ssh_key               = length(var.eks_worker_group_remote_access_ec2_ssh_keys) == var.eks_node_group_count ? element(var.eks_worker_group_remote_access_ec2_ssh_keys, count.index) : null
      source_security_group_ids = length(var.eks_worker_group_remote_access_ec2_ssh_keys) == var.eks_node_group_count ? element(var.eks_worker_group_remote_access_ec2_ssh_keys, count.index) : null
    }
  }

  scaling_config {
    desired_size = element(var.eks_node_group_desired_sizes, count.index)
    max_size     = element(var.eks_node_group_max_sizes, count.index)
    min_size     = element(var.eks_node_group_min_sizes, count.index)
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.this[0],
    aws_iam_role_policy_attachment.this[1],
    aws_iam_role_policy_attachment.this[2],
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
