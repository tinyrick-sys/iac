resource "proxmox_virtual_environment_download_file" "cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "proxmox"
  overwrite = true
  url = "https://github.com/nodadyoushutup/cloud-image/releases/download/0.1.12/cloud-image-x86-64-jammy-0.1.12.img"
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "proxmox"

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
      - ["${var.NAS_TRUENAS_IP_ADDRESS}:${var.NAS_NFS_MEDIA}", "${var.NAS_NFS_MEDIA}", "nfs", "defaults,nofail", "0", "2"]
    runcmd:
      - su - ${var.VIRTUAL_MACHINE_USERNAME} -c "ssh-import-id gh:${var.GITHUB_USERNAME}"
      - mkdir -p ${var.NAS_NFS_MEDIA}
      - chown ${var.VIRTUAL_MACHINE_USERNAME}:${var.VIRTUAL_MACHINE_USERNAME} ${var.NAS_NFS_MEDIA}
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "docker" {
    depends_on = [
        proxmox_virtual_environment_download_file.cloud_image,
        proxmox_virtual_environment_file.cloud_config
    ]
    
    # REQUIRED
    ################################################
    node_name = "proxmox"

    # OPTIONAL
    ################################################

    agent {
        enabled = true
        timeout = "5m"
        trim = false
        type = "virtio"
    }

    audio_device {
        device = "intel-hda"
        driver = "spice"
        enabled = true
    }

    bios = "ovmf"

    boot_order = ["scsi0"]

    cpu {
        # architecture = "x86_64" # Can only be set running terraform as root
        cores = 4
        flags = ["+aes"]
        hotplugged = 0
        limit = 0
        numa = false
        sockets = 1
        type = "x86-64-v2-AES"
        units = 1024
        affinity = null
    }

    description = "docker"

    disk {
        aio = "io_uring"
        backup = true
        cache = "none"
        datastore_id = "virtualization"
        path_in_datastore = null
        discard = "on"
        file_format = "raw"
        file_id = proxmox_virtual_environment_download_file.cloud_image.id
        interface = "scsi0"
        iothread = false
        replicate = true
        serial = null
        size = 10
        # speed = {
        #     iops_read = null 
        #     iops_read_burstable = null
        #     iops_write = null
        #     iops_write_burstable = null
        #     read = null
        #     read_burstable = null
        #     write = null
        #     write_burstable = null
        # }
        ssd = true
    }

    efi_disk {
        datastore_id = "virtualization"
        file_format = "raw"
        type = "4m"
        pre_enrolled_keys = false
    }

    initialization {
        datastore_id = "virtualization"
        user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
        
        ip_config {
            ipv4 {
                address = "192.168.0.202/24"
                gateway = "192.168.0.1"
            }
            ipv6 {
                address = "dhcp"
            }
        }
    }

    machine = "q35"

    memory {
        dedicated = 16384
        floating = 0
        shared = 0
        hugepages = null
        keep_hugepages = null
    }

    name = "docker"

    network_device {
        bridge = "vmbr0"
        disconnected = false
        enabled = true
        firewall = false
        mac_address = "0a:00:00:00:11:02"
        model = "virtio"
        mtu = null
        queues = null
        rate_limit = null
        vlan_id = null
        trunks = null
    }

    on_boot = true

    operating_system {
        type = "l26"
    }

    # pool_id = "docker"

    started = true

    startup {
        order = 2
        up_delay = 0
        down_delay = 0
    }

    tags = ["terraform", "cloud-image", "docker"]

    stop_on_destroy = true

    vga {
        memory = 16
        type = "qxl"
        clipboard = "vnc"
    }

    vm_id = 102
}