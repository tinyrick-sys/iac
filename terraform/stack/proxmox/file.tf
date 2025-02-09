resource "proxmox_virtual_environment_download_file" "cloud_image" {
  content_type = "iso"
  datastore_id = var.VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_ISO
  node_name = var.PROXMOX_VE_SSH_NODE_NAME
  overwrite = true
  overwrite_unmanaged = true
  url = var.PROXMOX_VE_CLOUD_IMAGE_URL
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_SNIPPET
  node_name = var.PROXMOX_VE_SSH_NODE_NAME

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - docker: [${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}]
    users:
      - default
      - name: ${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}
        groups: sudo
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
    mounts:
      - ["${var.VIRTUAL_MACHINE_TRUENAS_IP_ADDRESS}:${var.VIRTUAL_MACHINE_TRUENAS_NFS_MEDIA}", "${var.VIRTUAL_MACHINE_TRUENAS_NFS_MEDIA}", "nfs", "defaults,nofail", "0", "2"]
    runcmd:
      - su - ${var.VIRTUAL_MACHINE_GLOBAL_USERNAME} -c "ssh-import-id gh:${var.GITHUB_USERNAME}"
      - mkdir -p ${var.VIRTUAL_MACHINE_TRUENAS_NFS_MEDIA}
      - chown ${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}:${var.VIRTUAL_MACHINE_GLOBAL_USERNAME} ${var.VIRTUAL_MACHINE_TRUENAS_NFS_MEDIA}
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}