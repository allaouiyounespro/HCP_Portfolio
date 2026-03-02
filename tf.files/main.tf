terraform {
  cloud {
    organization = "gatsuga-labs"

    workspaces {
      name = "HCP_Portfolio"
    }
  }
}