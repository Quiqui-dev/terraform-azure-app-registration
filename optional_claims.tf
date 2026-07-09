locals {
  optional_claims_enabled = anytrue([
    length(coalesce(var.access_token_claims, toset([]))) > 0,
    length(coalesce(var.id_token_claims, toset([]))) > 0,
    length(coalesce(var.saml2_token_claims, toset([]))) > 0,
  ])
}

resource "azuread_application_optional_claims" "this" {
  count = local.optional_claims_enabled ? 1 : 0

  application_id = azuread_application.this.id

  dynamic "access_token" {
    for_each = coalesce(var.access_token_claims, toset([]))
    iterator = item

    content {
      name                  = item.value["name"]
      essential             = item.value["essential"]
      source                = item.value["source"]
      additional_properties = item.value["additional_properties"]
    }
  }

  dynamic "id_token" {
    for_each = coalesce(var.id_token_claims, toset([]))
    iterator = item

    content {
      name                  = item.value["name"]
      essential             = item.value["essential"]
      source                = item.value["source"]
      additional_properties = item.value["additional_properties"]
    }
  }

  dynamic "saml2_token" {
    for_each = coalesce(var.saml2_token_claims, toset([]))
    iterator = item

    content {
      name                  = item.value["name"]
      essential             = item.value["essential"]
      source                = item.value["source"]
      additional_properties = item.value["additional_properties"]
    }
  }
}
