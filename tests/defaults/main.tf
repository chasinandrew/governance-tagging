module "tagging-exclude" {
    source = "../.."
    parent = "organizations/955955086449"
    key_name = "excludeFromOrgPolicy"
    values_list = ["domainRestrictedSharing","VpcPeering"]
}
