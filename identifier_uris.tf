resource "azuread_application_identifier_uri" "this" {
  application_id = azuread_application.this.id
  identifier_uri = var.identifier_uri == null ? "api://${azuread_application.this.client_id}" : var.identifier_uri
}