resource "google_tags_tag_key" "key" {
  parent = "organizations/123456789"
  short_name = "excludeFromOrgPolicy"
  description = "For keyname resources."
}

#TODO: iterator for values 
resource "google_tags_tag_value" "value" {
    for_each = var.values_list
    parent = "tagKeys/${google_tags_tag_key.key.name}"
    short_name = "domainRestrictedSharing"
}
