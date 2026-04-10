resource "azuread_application_federated_identity_credential" "this" {
  for_each = var.federated_credentials == null ? {} : var.federated_credentials

  application_id = azuread_application.this.id
  display_name   = each.value["display_name"]
  description    = each.value["description"]
  audiences      = each.value["audiences"]
  issuer         = each.value["issuer"]
  subject        = each.value["subject"]
}