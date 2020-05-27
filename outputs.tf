#####
# IAM Role
#####

output "iam_role_arn" {
  value = element(concat(aws_iam_role.this.*.arn, list("")), 0)
}

output "iam_role_id" {
  value = element(concat(aws_iam_role.this.*.id, list("")), 0)
}

output "iam_role_name" {
  value = element(concat(aws_iam_role.this.*.name, list("")), 0)
}

#####
# EKS Node Group
#####

output "eks_node_group_arns" {
  value = compact(aws_eks_node_group.with_ignore_changes_on_desired_size.*.arn, aws_eks_node_group.output.without_ignore_changes_on_desired_size.*.arn)
}

output "eks_node_group_ids" {
  value = compact(aws_eks_node_group.with_ignore_changes_on_desired_size.*.arn, aws_eks_node_group.output.without_ignore_changes_on_desired_size.*.arn)
}
