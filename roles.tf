
# Generate GUIDs for the app roles
resource "random_uuid" "role_uuids" {
  for_each = coalesce(var.app_roles, {})
}

resource "azuread_application_app_role" "application_registration_roles" {
  for_each = coalesce(var.app_roles, {})

  application_id       = azuread_application.this.id
  role_id              = random_uuid.role_uuids[each.key].result
  allowed_member_types = each.value.allowed_member_types
  description          = each.value.description
  display_name         = each.value.display_name
  value                = each.key
}
