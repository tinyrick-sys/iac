terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

provider "proxmox" {
  endpoint = var.PROXMOX_VE_ENDPOINT
  password = var.PROXMOX_VE_PASSWORD
  username = var.PROXMOX_VE_USERNAME
  random_vm_ids = true
  insecure = true
  ssh {
    agent = true
    # agent_socket = 1022
    username = var.PROXMOX_VE_SSH_USERNAME
    private_key = file(var.SSH_PRIVATE_KEY)
    node {
      name    = var.PROXMOX_VE_SSH_NODE_NAME
      address = var.PROXMOX_VE_SSH_NODE_ADDRESS
    }
  }
}