mock_provider "azuread" {}
mock_provider "time" {}
mock_provider "random" {}

run "plan_minimal_required_inputs" {
    command = plan

    variables {
        description = "a minimal test app reg"
        display_name = "test-app-minimal"
    }

    assert {
        condition = azuread_application.this.display_name == "test-app-minimal"
        error_message = "display_name should match input"
    }

    assert {
        condition = azuread_application.this.description == "a minimal test app reg"
        error_message = "description should match input"
    }

    assert {
        condition = azuread_application.this.device_only_auth_enabled == false
        error_message = "device_only_auth_enabled should default to false"
    }

    assert {
        condition = azuread_application.this.fallback_public_client_enabled == false
        error_message = "fallback_public_client_enabled should default to false"
    }
}