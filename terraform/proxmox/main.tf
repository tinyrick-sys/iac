resource "proxmox_virtual_environment_download_file" "cloud_image_jammy_0_1_12" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "proxmox"
  url = "https://github.com/nodadyoushutup/cloud-image/releases/download/0.1.12/cloud-image-x86-64-jammy-0.1.12.img"
}