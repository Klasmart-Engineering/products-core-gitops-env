terraform {
  cloud {
    organization = "kidsloop-infrastructure"
    workspaces {
      name = "products-core-apifactory-uk"
    }
  }
}
