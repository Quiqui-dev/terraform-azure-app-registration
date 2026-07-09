
locals {

  scope_name_to_id = {
    for api_scope in azuread_application_permission_scope.api_scope :
    api_scope.value => api_scope.id
  }

  preauthorized_client_scope_pairs = flatten([
    for scope_name, scope_config in coalesce(var.api_permissions_scope, tomap({})) : [
      for client_id in coalesce(scope_config.preauthorized_client_ids, []) : {
        client_id  = client_id
        scope_name = scope_name
      }
    ]
  ])

  preauthorized_client_permission_ids = {
    for client_id in distinct([for pair in local.preauthorized_client_scope_pairs : pair.client_id]) :
    client_id => [
      for scope_name in distinct([
        for pair in local.preauthorized_client_scope_pairs : pair.scope_name
        if pair.client_id == client_id
      ]) : local.scope_name_to_id[scope_name]
    ]
  }
}

resource "azuread_application_pre_authorized" "this" {
  for_each             = local.preauthorized_client_permission_ids
  application_id       = azuread_application.this.id
  authorized_client_id = each.key
  permission_ids       = each.value
}
