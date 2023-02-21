module "tagging-exclude" {
    parent = "orgId"
    key = "exclude"
    value = ["",""]
}

module "tagging-include" {
    parent = "orgId"
    key = "include"
    value = ["",""]
}
