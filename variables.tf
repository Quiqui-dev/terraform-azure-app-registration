variable "description" {
  type        = string
  nullable    = false
  description = "description of the app reg to be created"
}

variable "api_settings" {
  type = object({
    known_client_applications      = optional(set(string))
    mapped_claims_enabled          = optional(bool, false)
    requested_access_token_version = optional(number, 2)
  })
  nullable    = false
  description = "A set of values that are set in the api{} block of the app reg"
}

variable "device_only_auth_enabled" {
  type        = bool
  nullable    = false
  default     = false
  description = "Set to enable auth without a user"
}

variable "display_name" {
  type        = string
  nullable    = false
  description = "The name of the app reg to create, what will be displayed in entra"
}

variable "fallback_public_client_enabled" {
  type        = bool
  nullable    = false
  default     = false
  description = "Set to specify if the app is a public client"
}

variable "feature_tags_settings" {
  type = object({
    custom_single_sign_on = optional(bool, false)
    enterprise            = optional(bool, false)
    gallery               = optional(bool, false)
    hide                  = optional(bool, false)
  })
  nullable    = true
  description = "A set of values which are set in the feature_tags{} block of the app reg"
}

variable "group_membership_claims" {
  type        = set(string)
  nullable    = true
  default     = null
  description = "set of claims to include in access tokens"
}

variable "logo_image" {
  type        = string
  nullable    = true
  default     = null
  description = "base64 encoded string of a jpg, gif, or png for this app reg logo"
}

variable "marketing_url" {
  type        = string
  nullable    = true
  default     = null
  description = "link to a marketing url"
}

variable "notes" {
  type        = string
  nullable    = true
  default     = null
  description = "notes regarding the app reg"
}

variable "oauth2_post_response_required" {
  type        = bool
  nullable    = false
  default     = false
  description = "is a POST request allowed by AzureAD / Entra as opposed to GET, as GET is the only allowed type by default"
}

variable "owners" {
  type        = set(string)
  nullable    = true
  default     = null
  description = "A set of object ids that are the owners of this app reg"
}

variable "prevent_duplicate_names" {
  type        = bool
  nullable    = true
  default     = true
  description = "Prevents app reg with duplicate names"
}

variable "privary_statement_url" {
  type        = string
  nullable    = true
  default     = null
  description = "Link to a privacy statement URL"
}

variable "public_client_redirect_urlis" {
  type        = set(string)
  nullable    = true
  default     = null
  description = "a set of public redirect uris after authentication"
}

variable "sign_in_audience" {
  type     = string
  nullable = false
  default  = "AzureADMyOrg"
  validation {
    condition     = contains(["AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount", "PersonalMicrosoftAccount"], var.sign_in_audience)
    error_message = "Must be one of: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, PersonalMicrosoftAccount"
  }
}

variable "single_page_app_redirect_uris" {
  type        = set(string)
  nullable    = true
  default     = null
  description = "a list of redirect uris if the SPA type is used"
}

variable "support_url" {
  type        = string
  nullable    = true
  default     = null
  description = "a link to a support url"
}

variable "template_id" {
  type     = string
  nullable = true
  default  = null
}

variable "terms_of_service_url" {
  type        = string
  nullable    = true
  default     = null
  description = "a link to the terms of service url"
}

variable "web_settings" {
  type = object({
    homepage_url                                 = optional(string, null)
    implicit_grant_access_token_issuance_enabled = optional(bool, false)
    implicit_grant_id_token_issuance_enabled     = optional(bool, false)
    logout_url                                   = optional(string, null)
    redirect_uris                                = optional(set(string), null)
  })
  nullable    = true
  description = "an object representing a web app configuration"
}

variable "app_roles" {
  type = map(object({
    allowed_member_types = set(string)
    description          = optional(string)
    display_name         = string
  }))
  nullable    = true
  default     = null
  description = "a set defining the membership type - user, app, or both"
}

variable "access_token_claims" {
  type = set(object({
    name                  = string
    source                = string
    essential             = bool
    additional_properties = list(string)
  }))
  default     = null
  nullable    = true
  description = "set of access token claims"
}

variable "saml2_token_claims" {
  type = set(object({
    name                  = string
    source                = string
    essential             = bool
    additional_properties = list(string)
  }))
  default     = null
  nullable    = true
  description = "set of saml2 token claims"
}

variable "id_token_claims" {
  type = set(object({
    name                  = string
    source                = string
    essential             = bool
    additional_properties = list(string)
  }))
  default     = null
  nullable    = true
  description = "set of id token claims"
}

variable "client_secret_name" {
  type        = string
  nullable    = true
  default     = null
  description = "name of the client secret to create"
}

variable "client_secret_lifetime" {
  type        = string
  default     = null
  nullable    = true
  description = "offste DateTime for the client secret to expire"
}

variable "identifier_uri" {
  type        = string
  default     = null
  nullable    = true
  description = "the uri that identifies the app reg in this tenant"
}

variable "api_permissions_scope" {
  type = map(object({
    admin_consent_description  = string
    admin_consent_display_name = string
    enabled                    = optional(bool, true)
    type                       = string
    user_consent_description   = string
    user_consent_display_name  = string
    preauthorized_client_ids   = optional(list(string), null)
  }))
  nullable    = true
  default     = null
  description = "The permissions scope definition for the API"
}

variable "api_permissions" {
  type = map(object({
    api_client_id = string
    scope_ids     = list(string)
    role_ids      = list(string)
  }))
  nullable    = true
  default     = null
  description = "The api permissions assigned. if granting permissions to self, use the api_permissions_self variable"
}

variable "api_permissions_self" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "ONLY USE FOR PERMISSIONS TO SELF. Handles edge casees of granting permissions for a role to itself"
}

variable "federated_credentials" {
  type = map(object({
    display_name = string
    description  = string
    audiences    = list(string)
    issuer       = string
    subject      = string
  }))
  nullable    = true
  default     = null
  description = "any federated credentials to configure for the app registration"
}

variable "service_management_reference" {
  type        = string
  nullable    = true
  default     = null
  description = "A reference which can be stored in a configuration management tool"
}

