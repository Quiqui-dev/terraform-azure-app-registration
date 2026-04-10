output "client_id" {
  value = azuread_application.this.client_id
}

output "client_secret" {
  value = azuread_application_password.this.value
}

output "application_roles" {
  value = azuread_application_app_role.application_registration_roles
}

output "id" {
  value = azuread_application.this.id
}
