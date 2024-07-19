# Overview

This Quick Start terraform module deploys Lambda function on the Amazon Web Services (AWS) Cloud.

This Lambda function creates mirror session for newly created EC2 instances by matching a certain tag key value pair.

This module can be combined with the [terraform-aws-vsensor](https://github.com/darktrace/terraform-aws-vsensor) module.

# Usage

## Before you start

The Lambda function creates mirror sessions for all newly created instances with the selected `tag_key` / `tag_value`.

## Deploy the module

```
module "lambda_mirror_new_instance" {
  source = "git::https://github.com/darktrace/terraform-aws-mirror-on-new-instance?ref=<version>"

  session_number           = "1"
  tag_key                  = "Mirroring"
  tag_value                = "True"
  traffic_mirror_filter_id = "tmt-xxxxxxxxxxxxxxxxx"
  traffic_mirror_target_id = "tmf-xxxxxxxxxxxxxxxxx"
  virtual_network_id       = "1"
}
```

## Deploy the module together with the vSesnor module

```
module "lambda_mirror_new_instance" {
  source = "git::https://github.com/darktrace/terraform-aws-mirror-on-new-instance?ref=<version>"

  session_number           = "1"
  tag_key                  = "Mirroring"
  tag_value                = "True"
  traffic_mirror_filter_id = module.vsensors.traffic_mirror_filter_id
  traffic_mirror_target_id = module.vsensors.traffic_mirror_target_id
  virtual_network_id       = "1"
}

module "vsensors" {
  source = "git::https://github.com/darktrace/terraform-aws-vsensor?ref=<version>"

  deployment_prefix = "dt"

  vpc_enable            = true
  vpc_cidr              = "10.0.0.0/16"
  availability_zone     = ["eu-west-1a", "eu-west-1b"]
  private_subnets_cidrs = ["10.0.0.0/23", "10.0.2.0/23"]
  public_subnets_cidrs  = ["10.0.246.0/23", "10.0.248.0/23"]

  update_key           = "dt_update_key"
  push_token           = "dt_push_token"
  instance_host_name   = "dt-master-instance.com"

  desired_capacity = 2
  max_size         = 2
  min_size         = 2
}
```

# Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.23 |

# Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.4.2 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.23 |

# Modules

No modules.

# Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.new_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.mirror_lambda_minimal_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.mirror_lambda_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_basic_execution_poicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.mirror_lambda_minimal_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.mirror_on_new_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [archive_file.mirror_on_new_instance](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy.lambda_basic_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.mirror_lambda_minimal_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_architecture"></a> [lambda\_architecture](#input\_lambda\_architecture) | Architecture for your Lambda function. Valid values are x86\_64 and arm64. Default is x86\_64 | `list` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_session_number"></a> [session\_number](#input\_session\_number) | Session number. | `string` | n/a | yes |
| <a name="input_tag_key"></a> [tag\_key](#input\_tag\_key) | Tag key. | `string` | n/a | yes |
| <a name="input_tag_value"></a> [tag\_value](#input\_tag\_value) | Tag value. | `string` | n/a | yes |
| <a name="input_traffic_mirror_filter_id"></a> [traffic\_mirror\_filter\_id](#input\_traffic\_mirror\_filter\_id) | Traffic mirror filter id. | `string` | n/a | yes |
| <a name="input_traffic_mirror_target_id"></a> [traffic\_mirror\_target\_id](#input\_traffic\_mirror\_target\_id) | Traffic mirror target id. | `string` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | Virtual network id. | `string` | n/a | yes |

# Outputs

No outputs.

# Related Projects

Check out these related projects.

- [terraform-aws-vsensor](https://github.com/darktrace/terraform-aws-vsensor)
- [terraform-azure-vsensor](https://github.com/darktrace/terraform-azure-vsensor)
- [terraform-gcp-vsensor](https://github.com/darktrace/terraform-gcp-vsensor)
