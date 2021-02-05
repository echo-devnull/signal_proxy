##
# This sets up a bog - standard scaleway framework
# for me to start working

terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

