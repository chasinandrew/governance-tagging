locals {
  gcp_org_policy_config_v2 = {
    "iam.allowedPolicyMemberDomains" = {
      policy_type = "list"
      rules = [
        #Rule 1
        {
          enforcement = true
          allow = [var.allowed_customer_ids]
          conditions = []
          },
           {
          enforcement = true
          allow       = []
          conditions = [{
            title       = "Project tags for excluding from this Organization Policy."
            description = "Any project matching this expression will be EXCLUDED from the iam.allowedPolicyMemberDomain organization constraint."
            expression  = "resource.matchTag('${var.organization_id}/excludedFromOrgPolicy','allowedPolicyMemberDomains') || resource.matchTag('${var.organization_id}/excludedFromOrgPolicy','allUserIngress')"
            location    = "sample-location.log"
          }]
        }
      ]
    }
  }
}