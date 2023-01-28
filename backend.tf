terraform {
  cloud {
    organization = "FusionIT"

    workspaces {
      name = "gh-action-demo-eva"
    }
  }
}