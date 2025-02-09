resource "proxmox_virtual_environment_vm" "development" {
    depends_on = [
        proxmox_virtual_environment_download_file.cloud_image,
        proxmox_virtual_environment_file.cloud_config
    ]
    
    # REQUIRED
    ################################################
    node_name = var.PROXMOX_VE_SSH_NODE_NAME

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
        cores = var.VIRTUAL_MACHINE_DEVELOPMENT_CPU_CORES
        flags = ["+aes"]
        hotplugged = 0
        limit = 0
        numa = false
        sockets = 1
        type = "x86-64-v2-AES"
        units = 1024
        affinity = null
    }

    description = "development"

    disk {
        aio = "io_uring"
        backup = true
        cache = "none"
        datastore_id = var.VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_DISK
        path_in_datastore = null
        discard = "on"
        file_format = "raw"
        file_id = proxmox_virtual_environment_download_file.cloud_image.id
        interface = "scsi0"
        iothread = false
        replicate = true
        serial = null
        size = var.VIRTUAL_MACHINE_DEVELOPMENT_DISK_SIZE
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
        datastore_id = var.VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_DISK
        file_format = "raw"
        type = "4m"
        pre_enrolled_keys = false
    }

    initialization {
        datastore_id = var.VIRTUAL_MACHINE_GLOBAL_DATASTORE_ID_DISK
        user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
        
        ip_config {
            ipv4 {
                address = "${var.VIRTUAL_MACHINE_DEVELOPMENT_IP_ADDRESS}/24"
                gateway = var.VIRTUAL_MACHINE_GLOBAL_GATEWAY
            }
            ipv6 {
                address = "dhcp"
            }
        }
    }

    machine = "q35"

    memory {
        dedicated = var.VIRTUAL_MACHINE_DEVELOPMENT_MEMORY_DEDICATED
        floating = 0
        shared = 0
        hugepages = null
        keep_hugepages = null
    }

    name = "development"

    network_device {
        bridge = "vmbr0"
        disconnected = false
        enabled = true
        firewall = false
        mac_address = var.VIRTUAL_MACHINE_DEVELOPMENT_MAC_ADDRESS
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

    # pool_id = "development"

    started = true

    startup {
        order = 2
        up_delay = 0
        down_delay = 0
    }

    tags = ["terraform", "cloud-image", "development"]

    stop_on_destroy = true

    vga {
        memory = 16
        type = "qxl"
        clipboard = "vnc"
    }

    vm_id = var.VIRTUAL_MACHINE_DEVELOPMENT_VMID
}

resource "null_resource" "exec_development" {
    depends_on = [proxmox_virtual_environment_vm.development]
    triggers = {
        always_run = timestamp()
    }
  
    connection {
        type = local.exec.connection.development.type
        user = local.exec.connection.development.user
        private_key = local.exec.connection.development.private_key
        host = local.exec.connection.development.host
        port = local.exec.connection.development.port
    }

    provisioner "remote-exec" {
        inline = concat(
            local.exec.inline.hostname.development, 
            local.exec.inline.hostname.restart, 
            local.exec.inline.gitconfig,
            local.exec.inline.private_key
        )
    }
}