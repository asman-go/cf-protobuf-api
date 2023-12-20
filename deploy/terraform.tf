terraform {
  backend "s3" {
    key = "asman-remote-state"
    dynamodb_table = "lock"
  }

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"
}

provider "yandex" {}
