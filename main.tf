resource "azuread_application" "this" {
  display_name = var.display_name
  description  = var.description

  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled

  api {
    known_client_applications = var.api_settings.known_client_applications
    mapped_claims_enabled     = var.api_settings.mapped_claims_enabled
    # oauth2_permission_scope is performed by separate resource - azuread_application_permission_scope
    requested_access_token_version = var.api_settings.requested_access_token_version
  }

  feature_tags {
    custom_single_sign_on = try(var.feature_tags_settings.custom_single_sign_on, false)
    enterprise            = try(var.feature_tags_settings.enterprise, false)
    gallery               = try(var.feature_tags_settings.gallery, false)
    hide                  = try(var.feature_tags_settings.hide, false)
  }

  group_membership_claims       = var.group_membership_claims
  logo_image                    = var.logo_image
  marketing_url                 = var.marketing_url
  notes                         = var.notes
  owners                        = var.owners
  oauth2_post_response_required = var.oauth2_post_response_required

  prevent_duplicate_names = var.prevent_duplicate_names
  privacy_statement_url   = var.privary_statement_url

  public_client {
    redirect_uris = var.public_client_redirect_urlis
  }

  service_management_reference = var.service_management_reference

  sign_in_audience = var.sign_in_audience

  single_page_application {
    redirect_uris = var.single_page_app_redirect_uris
  }

  support_url          = var.support_url
  template_id          = var.template_id
  terms_of_service_url = var.terms_of_service_url

  web {
    homepage_url = try(var.web_settings.homepage_url, null)
    implicit_grant {
      access_token_issuance_enabled = try(var.web_settings.implicit_grant_access_token_issuance_enabled, false)
      id_token_issuance_enabled     = try(var.web_settings.implicit_grant_id_token_issuance_enabled, false)
    }
    logout_url    = try(var.web_settings.logout_url, null)
    redirect_uris = try(var.web_settings.redirect_uris, null)
  }

  lifecycle {

    precondition {
      condition     = (var.client_secret_name == null) == (var.client_secret_lifetime == null)
      error_message = "client_secret_name and client_secret_lifetime must either both be set or both be null"
    }

    precondition {
      condition = alltrue([
        for role_name in coalesce(var.api_permissions_self, []) :
        contains(keys(coalesce(var.app_roles, {})), role_name)
      ])
      error_message = "Every entry in api_permissions_self must exist as a key in app_roles"
    }

    precondition {
      condition     = try(var.identifier_uri == null || trimspace(var.var.identifier_uri) != "", true)
      error_message = "identifier_uri must not be empty when provided"
    }

    ignore_changes = [
      app_role,
      api[0].oauth2_permission_scope,
      optional_claims,
      identifier_uris,
      password,
      required_resource_access
    ]
  }
}
