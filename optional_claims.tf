resource "azuread_application_optional_claims" "this" {
  count = var.access_token_claims == null && var.id_token_claims == null && var.saml2_token_claims == null ? 0 : 1

  application_id = azuread_application.this.id

  dynamic "access_token" {
    for_each = var.access_token_claims == null ? toset([]) : var.access_token_claims
    iterator = item

    content {
      name                  = item.value["name"]
      essential             = item.value["essential"]
      source                = item.value["source"]
      additional_properties = item.value["additional_properties"]
    }
  }

  dynamic "id_token" {
    for_each = var.id_token_claims == null ? toset([]) : var.id_token_claims
    iterator = item

    content {
      name                  = item.value["name"]
      essential             = item.value["essential"]
      source                = item.value["source"]
      additional_properties = item.value["additional_properties"]
    }
  }

  dynamic "saml2_token" {
    for_each = var.saml2_token_claims == null ? toset([]) : var.saml2_token_claims
    iterator = item

    content {
      name                  = item.value["name"]
      essential             = item.value["essential"]
      source                = item.value["source"]
      additional_properties = item.value["additional_properties"]
    }
  }
}