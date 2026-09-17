terraform {

  required_providers {

    proxmox = {

      source  = "bpg/proxmox"
      version = ">=0.80.0"

    }
  }
}

provider "proxmox" {

  endpoint  = var.pve_endpoint
  api_token = "${var.pve_token_id}=${var.pve_api_token}"
  insecure  = true

}
