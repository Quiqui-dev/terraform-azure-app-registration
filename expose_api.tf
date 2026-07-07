
resource "random_uuid" "this" {}

resource "azuread_application_permission_scope" "api_scope" {
  for_each = coalesce(var.api_permissions_scope, {})

  admin_consent_description  = each.value["admin_consent_description"]
  admin_consent_display_name = each.value["admin_consent_display_name"]
  application_id             = azuread_application.this.id
  scope_id                   = random_uuid.this.result
  type                       = each.value["type"]
  user_consent_description   = each.value["user_consent_description"]
  user_consent_display_name  = each.value["user_consent_display_name"]
  value                      = each.key
}
