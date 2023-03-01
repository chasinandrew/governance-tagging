locals {
  gcp_org_policy_config_v2 = {
    "iam.allowedPolicyMemberDomains" = {
      policy_type = "list"
      rules = [
        #Rule 1
        {
          enforcement = true
          allow = [
            #"C031ncvr9", # Identity Workspace for prod hcahealthcare.com
            #"C030fgx8u", # Identity workspace for Cerecore
            "is:C00pdrxjk", # Identity Workspace ID for hcaqa.corpadqa.net
            "is:C030fgx8u"  # Identity Workspace for Wiz.io scanning tool
          ]
        #   deny = []
          conditions = []
          }, {
          enforcement = true
          allow       = []
        #   deny = []
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