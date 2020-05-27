# terraform-module-aws-eks-node-group

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 12.0.0 |
| aws | >= 2.63 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.63 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_iam\_policy\_arns | List of additional policy arns that will be attached to the role. | `list(string)` | `[]` | no |
| create\_iam\_role | Whether to create the IAM role for the EKS Node Groups. | `bool` | `true` | no |
| eks\_cluster\_name | Name of the EKS Cluster. | `string` | n/a | yes |
| eks\_node\_group\_ami\_types | List of Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2\_x86\_64. Valid values: AL2\_x86\_64, AL2\_x86\_64\_GPU. Terraform will only perform drift detection if a configuration value is provided. | `list(string)` | `[]` | no |
| eks\_node\_group\_count | Number of nodes groups you speicifed in input. | `number` | n/a | yes |
| eks\_node\_group\_desired\_sizes | List of Desired number of worker nodes. | `list(string)` | n/a | yes |
| eks\_node\_group\_disk\_sizes | List of Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided. | `list(string)` | `[]` | no |
| eks\_node\_group\_force\_update\_versions | List of Force version update if existing pods are unable to be drained due to a pod disruption budget issue. | `list(string)` | `[]` | no |
| eks\_node\_group\_instance\_types | Set of instance types associated with the EKS Node Group. Defaults to ["t3.medium"]. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set. | `list(list(string))` | `[]` | no |
| eks\_node\_group\_labels | List of Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed. | `list(map(string))` | `[]` | no |
| eks\_node\_group\_max\_sizes | List of Maximum number of worker nodes. | `list(string)` | n/a | yes |
| eks\_node\_group\_min\_sizes | List of Minimum number of worker nodes. | `list(string)` | n/a | yes |
| eks\_node\_group\_names | List of the name of the EKS Node Groups. | `list(string)` | n/a | yes |
| eks\_node\_group\_node\_role\_arns | List of ARNs to be set on the EKS Node Groups. Conflict with `create_iam_role`. | `list(string)` | `[]` | no |
| eks\_node\_group\_release\_versions | List of AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version. | `list(string)` | `[]` | no |
| eks\_node\_group\_remote\_access\_ec2\_ssh\_keys | List of EC2 Key Pair name that provides access for SSH communication with the worker nodes in the EKS Node Group. If you specify this configuration, but do not specify source\_security\_group\_ids when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0). | `list(string)` | `[]` | no |
| eks\_node\_group\_remote\_access\_source\_security\_group\_ids | List of Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes. If you specify ec2\_ssh\_key, but do not specify this configuration when you create an EKS Node Group, port 22 on the worker nodes is opened to the Internet (0.0.0.0/0). | `list(list(string))` | `[]` | no |
| eks\_node\_group\_subnet\_ids | List of list of string of the subnet ids to deploy each node group in. | `list(list(string))` | n/a | yes |
| eks\_node\_group\_versions | List of Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided. | `list(string)` | `[]` | no |
| eks\_worker\_group\_tags | Map of tags that will be applied on all eks node groups. | `map` | `{}` | no |
| eks\_worker\_groups\_tags | List of map of tags that will be applied on the eks node group. | `list(map(string))` | `[]` | no |
| enabled | Whether or not to enable this module. | `bool` | `true` | no |
| iam\_role\_description | The description of the role. | `string` | `null` | no |
| iam\_role\_force\_detach\_policies | Specifies to force detaching any policies the role has before destroying it. | `bool` | `false` | no |
| iam\_role\_max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `null` | no |
| iam\_role\_name | The name of the role. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| iam\_role\_name\_prefix | Creates a unique name beginning with the specified prefix. Conflicts with name. | `string` | `null` | no |
| iam\_role\_path | The path to the role. | `string` | `null` | no |
| iam\_role\_permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| iam\_role\_tags | Key-value map of tags for the IAM role. | `map` | `{}` | no |
| ignore\_changes\_on\_desired\_size | Whether terraform should ignore changes on desied size of the EKS node group. (Set to true when implementing auto-scaling). | `bool` | `false` | no |
| tags | Key-value map of tags for all resources. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| eks\_node\_group\_arns | n/a |
| eks\_node\_group\_ids | n/a |
| iam\_role\_arn | n/a |
| iam\_role\_id | n/a |
| iam\_role\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Versioning
This repository follows [Semantic Versioning 2.0.0](https://semver.org/)

## Git Hooks
This repository uses [pre-commit](https://pre-commit.com/) hooks.
