resource "google_tags_tag_key" "key" {
  parent      = var.parent
  short_name  = var.key_name
  description = var.key_description
}

resource "google_tags_tag_value" "value" {
  count      = length(var.values_list)
  parent     = "tagKeys/${google_tags_tag_key.key.name}"
  short_name = var.values_list["${count.index}"]
}