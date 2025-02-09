terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

provider "docker" {
    host = "ssh://${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}@${var.VIRTUAL_MACHINE_DOCKER_IP_ADDRESS}:22"
    ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null", "-o", "IdentityFile=${var.SSH_PRIVATE_KEY}"]
}