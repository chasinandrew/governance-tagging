resource "google_tags_tag_key" "key" {
  parent = "organizations/123456789"
  short_name = "excludeFromOrgPolicy"
  description = "For keyname resources."
}

resource "google_tags_tag_value" "value" {
    parent = "tagKeys/${google_tags_tag_key.key.name}"
    short_name = "domainRestrictedSharing"
    description = "For valuename resources."
}
