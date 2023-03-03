module "tagging-exclude" {
  source      = "../.."
  parent      = "organizations/${var.org_id}"
  key_name    = "excludeFromOrgPolicy2"
  values_list = ["domainRestrictedSharing2", "VpcPeering2", "newValue"]
}
