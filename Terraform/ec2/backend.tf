terraform {
  backend "remote" {
    organization = "ngatchyd"

    workspaces {
      name = "komodo"
    }
  }
}

