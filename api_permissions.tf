resource "azuread_application_api_access" "this" {
  for_each = var.api_permissions == null ? {} : var.api_permissions

  application_id = azuread_application.this.id
  api_client_id  = each.value["api_client_id"]
  scope_ids      = each.value["scope_ids"]
}


resource "azuread_application_api_access" "self_assigned" {
  for_each = var.api_permissions_self == null ? {} : var.api_permissions_self

  application_id = azuread_application.this.id
  api_client_id  = azuread_application.this.client_id
  scope_ids      = [azuread_application_app_role.application_registration_roles[each.value].role_id]
}



