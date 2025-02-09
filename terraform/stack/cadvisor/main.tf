resource "docker_image" "cadvisor" {
    name = "gcr.io/cadvisor/cadvisor:v0.49.2"
}

resource "docker_container" "cadvisor" {
    depends_on = [docker_image.cadvisor]
    name  = "cadvisor"
    image = docker_image.cadvisor.image_id
    restart = "unless-stopped"
    privileged = true
    # wait = true
    network_mode = "bridge"
  
    ports {
        internal = "8080"
        external = "8082"
    }

    volumes {
        host_path = "/"
        container_path = "/rootfs"
    }

    volumes {
        host_path = "/var/run"
        container_path = "/var/run"
    }

    volumes {
        host_path = "/sys"
        container_path = "/sys"
    }

    volumes {
        host_path = "/var/lib/docker"
        container_path = "/var/lib/docker"
    }

    volumes {
        host_path = "/dev/disk"
        container_path = "/dev/disk"
    }

    devices {
        host_path = "/dev/kmsg"
    }

    # healthcheck {
    #     test = ["CMD", "curl", "-f", "http://192.168.1.102:8082/healthz"]
    #     interval = "5s"
    #     retries = 12
    # }
}