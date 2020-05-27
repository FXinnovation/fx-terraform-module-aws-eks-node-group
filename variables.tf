#####
# Global
#####

variable "enabled" {
  description = "Whether or not to enable this module."
  default     = true
}

variable "tags" {
  description = "Key-value map of tags for all resources."
  default     = {}
}

#####
# IAM
#####

variable "additional_iam_policy_arns" {
  description = "List of additional policy arns that will be attached to the role."
  type        = list(string)
  default     = []
}

variable "create_iam_role" {
  description = "Whether to create the IAM role for the EKS Node Groups."
  default     = true
}

variable "iam_role_name" {
  description = "The name of the role. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "iam_role_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "iam_role_force_detach_policies" {
  description = "Specifies to force detaching any policies the role has before destroying it."
  default     = false
}

variable "iam_role_path" {
  description = "The path to the role."
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "The description of the role."
  type        = string
  default     = null
}

variable "iam_role_max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
}

variable "iam_role_tags" {
  description = "Key-value map of tags for the IAM role."
  default     = {}
}

#####
# EKS Node Group
#####

variable "ignore_changes_on_desired_size" {
  description = "Whether terraform should ignore changes on desied size of the EKS node group. (Set to true when implementing auto-scaling)."
  default     = false
}

variable "eks_node_group_count" {
  description = "Number of nodes groups you speicifed in input."
  type        = number
}

variable "eks_cluster_name" {
  description = "Name of the EKS Cluster."
  type        = string
}

variable "eks_node_group_names" {
  description = "List of the name of the EKS Node Groups."
  type        = list(string)
}

variable "eks_node_group_node_role_arns" {
  description = "List of ARNs to be set on the EKS Node Groups. Conflict with `create_iam_role`."
  type        = list(string)
  default     = []
}

variable "eks_node_group_subnet_ids" {
  description = "List of list of string of the subnet ids to deploy each node group in."
  type        = list(list(string))
}

variable "eks_node_group_ami_types" {
  description = "List of Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided."
  type        = list(string)
  default     = []
}

variable "eks_node_group_disk_sizes" {
  description = "List of Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
  type        = list(string)
  default     = []
}

variable "eks_node_group_force_update_versions" {
  description = "List of Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  type        = list(string)
  default     = []
}

variable "eks_node_group_instance_types" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set."
  type        = list(list(string))
  default     = []
}

variable "eks_node_group_labels" {
  description = "List of Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed."
  type        = list(map(string))
  default     = []
}

variable "eks_node_group_release_versions" {
  description = "List of AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
  type        = list(string)
  default     = []
}

variable "eks_node_group_versions" {
  description = "List of Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  type        = list(string)
  default     = []
}

variable "eks_node_group_remote_access_ec2_ssh_keys" {
  description = "List of EC2 Key Pair name that provides access for SSH communication with the worker nodes in the EKS Node Group. If you specify this configuration, but do not specify source_security_group_ids when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0)."
  type        = list(string)
  default     = []
}

variable "eks_node_group_remote_access_source_security_group_ids" {
  description = "List of Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes. If you specify ec2_ssh_key, but do not specify this configuration when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0)."
  type        = list(list(string))
  default     = []
}

variable "eks_worker_group_tags" {
  description = "Map of tags that will be applied on all eks node groups."
  default     = {}
}

variable "eks_worker_groups_tags" {
  description = "List of map of tags that will be applied on the eks node group."
  type        = list(map(string))
  default     = []
}

variable "eks_node_group_desired_sizes" {
  description = "List of Desired number of worker nodes."
  type        = list(string)
}

variable "eks_node_group_min_sizes" {
  description = "List of Minimum number of worker nodes."
  type        = list(string)
}

variable "eks_node_group_max_sizes" {
  description = "List of Maximum number of worker nodes."
  type        = list(string)
}
