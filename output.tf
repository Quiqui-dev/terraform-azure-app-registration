output "client_id" {
  value = azuread_application.this.client_id
}

output "client_secret" {
  value     = contains(keys(azuread_application_password.this), "enabled") ? azuread_application_password.this["enabled"] : null
  sensitive = true
}

output "client_secret_start_date" {
  value = contains(keys(azuread_application_password.this), "enabled") ? azuread_application_password.this["enabled"].start_date : null
}

output "client_secret_end_date" {
  value = contains(keys(azuread_application_password.this), "enabled") ? azuread_application_password.this["enabled"].end_date : null
}

output "application_roles" {
  value = azuread_application_app_role.application_registration_roles
}

output "id" {
  value = azuread_application.this.id
}
