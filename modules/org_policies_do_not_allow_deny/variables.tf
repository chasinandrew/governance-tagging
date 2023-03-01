variable "policy_root" {
  description = <<INFO
  Resource hierarchy node to apply the policy to.
  Can be one of `organization`, `folder`, or `project`.
  INFO
  type        = string
  default     = "organization"

  validation {
    condition     = contains(["organization", "folder", "project"], var.policy_root)
    error_message = "Policy Root must be value of either `organization`, `folder`, or `project`."
  }
}

variable "policy_root_id" {
  description = <<INFO
  The policy root id, either of organization_id, folder_id or project_id.
  INFO
  type        = string
  default     = null
}

variable "exclude_folders" {
  description = <<INFO
  Set of folders to exclude from the policy.
  INFO
  type        = set(string)
  default     = []
}

variable "exclude_projects" {
  description = <<INFO
  Set of projects to exclude from the policy.
  INFO
  type        = set(string)
  default     = []
}

variable "constraint" {
  description = <<INFO
  The constraint to be applied"
  INFO
  type        = string

  validation {
    condition     = !can(regex("^constraints/", var.constraint))
    error_message = "The `var.constraint` should contain the substring 'constraints/' prefix."
  }

  validation {
    condition = contains([
      "cloudbuild.allowedIntegrations",
      "cloudfunctions.allowedIngressSettings",
      "cloudfunctions.allowedVpcConnectorEgressSettings",
      "cloudfunctions.requireVPCConnector",
      "compute.disableVpcExternalIpv6",
      "cloudbuild.allowedWorkerPools",
      "compute.requireVpcFlowLogs",
      "compute.requireShieldedVm",
      "compute.restrictCloudNATUsage",
      "iap.requireRegionalIapWebDisabled",
      "compute.restrictDedicatedInterconnectUsage",
      "compute.restrictLoadBalancerCreationForTypes",
      "compute.restrictPartnerInterconnectUsage",
      "compute.restrictProtocolForwardingCreationForTypes",
      "compute.restrictSharedVpcBackendServices",
      "compute.restrictSharedVpcHostProjects",
      "compute.restrictSharedVpcSubnetworks",
      "compute.restrictVpcPeering",
      "compute.restrictVpnPeerIPs",
      "compute.restrictXpnProjectLienRemoval",
      "compute.requireOsLogin",
      "compute.setNewProjectDefaultToZonalDNSOnly",
      "compute.sharedReservationsOwnerProjects",
      "compute.skipDefaultNetworkCreation",
      "compute.storageResourceUseRestrictions",
      "compute.trustedImageProjects",
      "compute.vmCanIpForward",
      "compute.vmExternalIpAccess",
      "datastream.disablePublicConnectivity",
      "essentialcontacts.allowedContactDomains",
      "essentialcontacts.disableProjectSecurityContacts",
      "firestore.requireP4SAforImportExport",
      "gcp.detailedAuditLoggingMode",
      "gcp.disableCloudLogging",
      "gcp.resourceLocations",
      "serviceuser.services",
      "gcp.restrictCmekCryptoKeyProjects",
      "gcp.restrictNonCmekServices",
      "bigquery.disableBQOmniAzure",
      "gcp.restrictServiceUsage",
      "iam.allowedPolicyMemberDomains",
      "iam.allowServiceAccountCredentialLifetimeExtension",
      "iam.automaticIamGrantsForDefaultServiceAccounts",
      "iam.disableAuditLoggingExemption",
      "iam.disableCrossProjectServiceAccountUsage",
      "iam.disableServiceAccountCreation",
      "iam.disableServiceAccountKeyCreation",
      "iam.disableServiceAccountKeyUpload",
      "iam.disableWorkloadIdentityClusterCreation",
      "iam.restrictCrossProjectServiceAccountLienRemoval",
      "iam.workloadIdentityPoolAwsAccounts",
      "iam.workloadIdentityPoolProviders",
      "iap.requireGlobalIapWebDisabled",
      "resourcemanager.accessBoundaries",
      "resourcemanager.allowedExportDestinations",
      "resourcemanager.allowedImportSources",
      "resourcemanager.allowEnabledServicesForExport",
      "clouddeploy.disableServiceLabelGeneration",
      "run.allowedIngress",
      "run.allowedVPCEgress",
      "storage.publicAccessPrevention",
      "storage.retentionPolicySeconds",
      "storage.uniformBucketLevelAccess",
    ], var.constraint)
    error_message = "Constraint must be a supported GCP Policy Constraint. See the full list here: https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints."
  }
}

variable "policy_type" {
  description = <<INFO
  The constraint INFO
  type to work with (either 'boolean' or 'list')
  INFO
  type        = string
  default     = "list"

  validation {
    condition = contains([
      "list",
      "boolean"
    ], var.policy_type)
    error_message = "Policy Type must be either boolean or list."
  }
}

variable "rules" {
  description = <<INFO
  List of rules per policy. Up to 10.
  enforcement = 
  allow = 
  deny = 
  conditions = 
  Format: 
  [
    # Rule 1
    {
      enforcement = false
      allow       = []
      deny        = []
      conditions  = []
    },
    # Rule 2
    {
      enforcement = false
      allow       = []
      deny        = []
      conditions = [{
        description = "description of the condition"
        expression  = "resource.matchTagId('tagKeys/123456789', 'tagValues/123456789') && resource.matchTag('123456789/1234', 'abcd')"
        location    = "sample-location.log"
        title       = "Title of the condition"
      }]
    },
  ]
  INFO
  type = list(object(
    {
      enforcement = bool
      allow       = list(string)
      conditions = list(object(
        {
          description = string
          expression  = string
          title       = string
          location    = string
        }
      ))
    }
  ))
}
