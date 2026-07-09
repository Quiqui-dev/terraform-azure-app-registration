mock_provider "azuread" {}
mock_provider "time" {}
mock_provider "random" {}

run "invalid_sign_in_audience" {
  command         = plan
  expect_failures = [var.sign_in_audience]

  variables {
    description      = "test invalid audience"
    display_name     = "test-app"
    sign_in_audience = "InvalidAudience"
  }
}