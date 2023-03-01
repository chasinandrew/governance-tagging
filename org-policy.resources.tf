module "governance-org-policy-v2" {
  for_each       = local.gcp_org_policy_config_v2
  source         = "./modules/org_policies_do_not_allow_deny"
  policy_root    = "organization"         # either of organization, folder or project
  policy_root_id = var.organization_id    # either of org id, folder id or project id
  constraint     = each.key               # constraint identifier without constriants/ prefix. Example "compute.requireOsLogin"
  policy_type    = each.value.policy_type # either of list or boolean
  rules          = each.value.rules
}