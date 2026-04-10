
locals {

  scope_and_scope_id = { for api_scope in azuread_application_permission_scope.api_scope : api_scope.value => api_scope.scope_id }

  scopes_with_preauthorized_client_ids = { for scope, value in coalesce(var.var.api_permissions_scope, tomap({})) : scope => flatten(value.preauthorized_client_ids) if value.preauthorized_client_ids != null }

  separated_scopes_with_preauthorized_client_ids = flatten([for role, ids in local.scopes_with_preauthorized_client_ids : [
    for id in ids : {
      role = role
      id   = id
    }
    ]
  ])

  temp_group = {}

  group_by_client_id = { for obj in local.separated_scopes_with_preauthorized_client_ids : obj.id => (
    contains(keys(local.temp_group), obj.id) ? concat(local.temp_group[obj.id], obj.role) : obj.role
    )...
  }

  replaced_role_name_with_scope_guid = {
    for id, roles in local.group_by_client_id : id => [
      for role in roles : local.scope_and_scope_id[role]
    ]
  }
}

resource "azuread_application_pre_authorized" "this" {
  for_each             = local.replaced_role_name_with_scope_guid
  application_id       = azuread_application.this.id
  authorized_client_id = each.key
  permission_ids       = each.value
}