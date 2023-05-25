data "aws_ssoadmin_instances" "this" {}

resource "aws_ssoadmin_permission_set" "this" {
  name             = var.name
  description      = var.description
  relay_state      = var.relay_state
  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  session_duration = var.session_duration
}

resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  count              = var.include_policy_json ? 1 : 0
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  inline_policy      = var.policy_json
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each           = toset(var.managed_policy_arns)
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = each.key
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
}

resource "aws_identitystore_group" "this" {
  display_name      = aws_ssoadmin_permission_set.this.name
  description       = aws_ssoadmin_permission_set.this.description
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_ssoadmin_account_assignment" "this" {
  for_each           = toset(var.target_account_ids)
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  principal_id   = aws_identitystore_group.this.group_id
  principal_type = "GROUP"

  target_id   = each.key
  target_type = "AWS_ACCOUNT"
}