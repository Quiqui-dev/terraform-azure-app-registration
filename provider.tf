terraform {

  required_version = ">=1.9.5"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=3.3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "->0.12.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
