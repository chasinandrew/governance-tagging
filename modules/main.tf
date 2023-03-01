/******************************************
  Locals configuration for module logic
 *****************************************/
locals {
  organization = var.policy_root == "organization"
  folder       = var.policy_root == "folder"
  project      = var.policy_root == "project"
  # Making the policy roots as plural with additional 's' in the end - organizations, folders, projects
  policy_root = format("%s%s", var.policy_root, "s")

  boolean_policy = var.policy_type == "boolean"
  list_policy    = var.policy_type == "list"

  # Appends the rules variable with additional details
  # allow and deny list length
  # enforcement (true or false)
  # values with allow and deny list items
  rules = [
    for k, v in var.rules :
    merge(v, {
      allow_list_length = length(v.allow),
      deny_list_length  = length(v.deny),
      enforcement       = length(v.allow) > 0 || length(v.deny) > 0 ? null : v.enforcement,
      values            = [{ allow = v.allow, deny = v.deny }]
    })
  ]
}