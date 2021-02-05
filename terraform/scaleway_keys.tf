##
# This file is encrypted using git-crypt so no worries!

##
# This is the access key for the correct project in scaleway
variable "access_key" {
  type        = string
  description = "Access key to get api access to Scaleway"
  default     = "notarealkey"
  sensitive   = true
}

##
# This is the secret key for the correct project in scaleway
variable "secret_key" {
  type      = string
  default   = "notarealsecret" #tfsec:ignore:GEN001
  sensitive = true
}

##
# This is id for the project to use
variable "organization_id" {
  type      = string
  default   = "notarealid"
  sensitive = true
}

provider "scaleway" {
  # alias      = "signal-proxy"
  zone            = "nl-ams-1"
  region          = "nl-ams"
  organization_id = var.organization_id
  access_key      = var.access_key #tfsec:ignore:GEN003
  secret_key      = var.secret_key
}