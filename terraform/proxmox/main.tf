terraform {
  required_version = ">= 0.12"
}

output "ssh_private_key" {
  value = "${var.SSH_PRIVATE_KEY}"
}

output "endpoint" {
  value = "${var.PROXMOX_VE_ENDPOINT}"
}

output "password" {
  value = "${var.PROXMOX_VE_PASSWORD}"
}

output "username" {
  value = "${var.PROXMOX_VE_USERNAME}"
}

output "ssh_node_address" {
  value = "${var.PROXMOX_VE_SSH_NODE_ADDRESS}"
}

output "ssh_node_name" {
  value = "${var.PROXMOX_VE_SSH_NODE_NAME}"
}

data "proxmox_virtual_environment_vms" "vms" {}

output "vms" {
  value = data.proxmox_virtual_environment_vms.vms
}