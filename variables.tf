variable "name" {
  type        = string
  description = "Name for the group and new policy group"
}
variable "description" {
  type        = string
  description = "Description for the group and new policy group"
}
variable "target_account_ids" {
  type        = list(string)
  description = "AWS account ids to deploy resources to"
}
variable "relay_state" {
  type        = string
  description = "The relay state URL used to redirect users within the application during the federation authentication proces (Optional)"
  default     = null
}
variable "include_policy_json" {
  default     = true
  description = "With dynamic JSON, terraform can't determine if the object should be created. This forces it."
}
variable "policy_json" {
  default = ""
}
variable "managed_policy_arns" {
  type    = list(string)
  default = []
}
variable "session_duration" {
  default = "PT1H"
}