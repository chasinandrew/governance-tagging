module "tagging-exclude" {
  source      = "../.."
  parent      = "organizations/955955086449"
  key_name    = "excludeFromOrgPolicy2"
  values_list = ["domainRestrictedSharing2", "VpcPeering2"]
}
