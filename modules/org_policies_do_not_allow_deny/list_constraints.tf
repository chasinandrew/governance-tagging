/******************************************
  Organization policy, allow all and allow values  (list constraint)
 *****************************************/
resource "google_org_policy_policy" "organization_policy" {
  count = local.organization && local.list_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  spec {
    dynamic "rules" {
      for_each = local.rules
      content {
        dynamic "condition" {
          for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
          content {
            description = condition.value.description
            expression  = condition.value.expression
            location    = condition.value.location
            title       = condition.value.title
          }
        }
        allow_all = rules.value.enforcement == true ? "TRUE" : null
        dynamic "values" {
          for_each = rules.value.allow_list_length > 0  ? rules.value.values : []
          content {
            allowed_values = rules.value.allow_list_length > 0 ? values.value.allow : null
          }
        }
      }
    }
  }
}

/******************************************
  Folder policy, allow all and allow values (list constraint)
 *****************************************/
resource "google_org_policy_policy" "folder_policy" {
  count = local.folder && local.list_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  spec {
    dynamic "rules" {
      for_each = local.rules
      content {
        dynamic "condition" {
          for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
          content {
            description = condition.value.description
            expression  = condition.value.expression
            location    = condition.value.location
            title       = condition.value.title
          }
        }
        allow_all = rules.value.enforcement == true ? "TRUE" : null
        dynamic "values" {
          for_each = rules.value.allow_list_length > 0 ? rules.value.values : []
          content {
            allowed_values = rules.value.allow_list_length > 0 ? values.value.allow : null
          }
        }
      }
    }
  }
}

/******************************************
  Project policy, allow all and allow values (list constraint)
 *****************************************/
resource "google_org_policy_policy" "project_policy" {
  count = local.project && local.list_policy ? 1 : 0

  name   = "${local.policy_root}/${var.policy_root_id}/policies/${var.constraint}"
  parent = "${local.policy_root}/${var.policy_root_id}"

  spec {
    dynamic "rules" {
      for_each = local.rules
      content {
        dynamic "condition" {
          for_each = { for k, v in rules.value.conditions : k => v if length(rules.value.conditions) > 0 }
          content {
            description = condition.value.description
            expression  = condition.value.expression
            location    = condition.value.location
            title       = condition.value.title
          }
        }
        allow_all = rules.value.enforcement == false ? "TRUE" : null
        dynamic "values" {
          for_each = rules.value.allow_list_length > 0  ? rules.value.values : []
          content {
            allowed_values = rules.value.allow_list_length > 0 ? values.value.allow : null
          }
        }
      }
    }
  }
}

/******************************************
  Exclude folders from policy (list constraint)
 *****************************************/
resource "google_org_policy_policy" "folder_policy_list_exclude_folders" {
  for_each = (local.list_policy && !local.project) ? var.exclude_folders : []

  name   = "folders/${each.value}/policies/${var.constraint}"
  parent = "folders/${each.value}"


  spec {
    reset = true
  }
}

/******************************************
  Exclude projects from policy (list constraint)
 *****************************************/
resource "google_org_policy_policy" "project_policy_list_exclude_projects" {
  for_each = (local.list_policy && !local.project) ? var.exclude_projects : []

  name   = "projects/${each.value}/policies/${var.constraint}"
  parent = "projects/${each.value}"

  spec {
    reset = true
  }
}