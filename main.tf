resource "azuread_application" "this" {
  display_name                   = var.display_name
  description                    = var.description
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled

  api {
    known_client_applications      = var.api_settings["known_client_applications"]
    mapped_claims_enabled          = var.api_settings["mapped_claims_enabled"]
    requested_access_token_version = var.api_settings["requested_access_token_version"]
  }

  feature_tags {
    custom_single_sign_on = var.feature_tags_settings["custom_single_sign_on"]
    enterprise            = var.feature_tags_settings["enterprise"]
    gallery               = var.feature_tags_settings["gallery"]
    hide                  = var.feature_tags_settings["hide"]
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
    homepage_url = var.web_settings["homepage_url"]
    implicit_grant {
      access_token_issuance_enabled = var.web_settings["implicit_grant_access_token_issuance_enabled"]
      id_token_issuance_enabled     = var.web_settings["implicit_grant_id_token_issuance_enabled"]
    }
    logout_url    = var.web_settings["logout_url"]
    redirect_uris = var.web_settings["redirect_uris"]
  }

  lifecycle {
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
