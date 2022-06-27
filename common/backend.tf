terraform {
  cloud {
    organization = "kidsloop-infrastructure"
    workspaces {
      name = "products-core-common-infrastructure"
    }
  }
}