resource "azuread_application_identifier_uri" "this" {
  application_id = azuread_application.this.id
  identifier_uri = coalesce(var.identifier_uri, "api://${azuread_application.this.client_id}")
}

