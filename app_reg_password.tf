resource "time_static" "this" {}

resource "azuread_application_password" "this" {
  for_each = var.client_secret_name != null && var.client_secret_lifetime != null ? toset(["enabled"]) : toset([])

  application_id = azuread_application.this.id
  display_name   = var.client_secret_name
  end_date       = timeadd(time_static.this.rfc3339, var.client_secret_lifetime)
}

