# Terraform AWS SSO User Module

This Terraform module creates AWS SSO users, groups, and permission sets.

## Resources

## Resources

The module creates the following resources:

| Resource                                           | Description                                                                                       |
|----------------------------------------------------|---------------------------------------------------------------------------------------------------|
| `aws_ssoadmin_permission_set`                      | Creates an AWS SSO permission set.                                                                |
| `aws_ssoadmin_permission_set_inline_policy`        | Attaches an inline policy to the AWS SSO permission set (optional).                               |
| `aws_ssoadmin_managed_policy_attachment`           | Attaches managed policies to the AWS SSO permission set.                                          |
| `aws_identitystore_group`                          | Creates an AWS SSO group in the identity store.                                                   |
| `aws_ssoadmin_account_assignment`                  | Assigns the AWS SSO permission set to the AWS SSO group in the specified AWS account.             |


## Variables

The module expects the following variables to be provided:

## Variables

| Variable               | Description                                                                                                      |
|------------------------|------------------------------------------------------------------------------------------------------------------|
| `name`                 | Name for the group and new policy group.                                                                          |
| `description`          | Description for the group and new policy group.                                                                   |
| `target_account_id`    | AWS account ID to deploy resources to.                                                                            |
| `relay_state`          | The relay state URL used to redirect users within the application during the federation authentication process (Optional). |
| `include_policy_json`  | With dynamic JSON, Terraform can't determine if the object should be created. This forces it.                    |
| `policy_json`          | Inline policy JSON to attach to the AWS SSO permission set.                                                      |
| `managed_policy_arns`  | List of managed policy ARNs to attach to the AWS SSO permission set.                                             |
| `session_duration`     | Duration for which the AWS SSO session is valid.                                                                 |


For more information on each variable, refer to the module's source code.

## Usage

```hcl
module "aws_sso_group" {
  source = "path/to/module"

  name             = "MyGroup"
  description      = "MyGroup description"
  target_account_id = "123456789012"
  relay_state      = null
  include_policy_json = true
  policy_json      = ""
  managed_policy_arns = []

  session_duration = "PT1H"
}

