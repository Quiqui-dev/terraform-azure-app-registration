terraform {

  required_version = ">=1.9.5"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=3.4.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.13.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
