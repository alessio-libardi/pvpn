terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "vpn" {
  name   = "VPN"
  image  = "sharklabs-piholevpn"
  size   = "s-1vcpu-512mb-10gb"
  region = "fra1"
}

resource "digitalocean_project"  "personal-cloud" {
  name        = "Personal Cloud"
  description = "Personal cloud resources"
  purpose     = "Other"
  environment = "Development"
  resources   = [digitalocean_droplet.vpn.urn]
  is_default  = true
}
