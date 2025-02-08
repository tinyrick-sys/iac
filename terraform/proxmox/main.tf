resource "proxmox_virtual_environment_download_file" "cloud_image_jammy_0_1_12" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "proxmox"
  url = "https://github.com/nodadyoushutup/cloud-image/releases/download/0.1.12/cloud-image-x86-64-jammy-0.1.12.img"
}
resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - docker: [${var.VIRTUAL_MACHINE_USERNAME}]
    users:
      - default
      - name: ${var.VIRTUAL_MACHINE_USERNAME}
        groups: sudo
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
    mounts:
      - ["${var.NAS_LOCAL_IP}:${var.NAS_NFS_MEDIA}", "${var.NAS_NFS_MEDIA}", "nfs", "defaults,nofail", "0", "2"]
    runcmd:
      - su - ${var.VIRTUAL_MACHINE_USERNAME} -c "ssh-import-id gh:${var.GITHUB_USERNAME}"
      - mkdir -p ${var.NAS_NFS_MEDIA}
      - chown ${var.VIRTUAL_MACHINE_USERNAME}:${var.VIRTUAL_MACHINE_USERNAME} ${var.NAS_NFS_MEDIA}
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}