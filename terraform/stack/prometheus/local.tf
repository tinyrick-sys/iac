locals {
    template = {
        prometheus = templatefile(
            "${path.module}/template/prometheus.yml.tpl", 
            {
                VIRTUAL_MACHINE_DOCKER_IP_ADDRESS=var.VIRTUAL_MACHINE_DOCKER_IP_ADDRESS
            }
        )
    }
    
    exec = {
        connection = {
            docker = {
                type = "ssh"
                user = var.VIRTUAL_MACHINE_GLOBAL_USERNAME
                private_key = file(var.SSH_PRIVATE_KEY)
                host = var.VIRTUAL_MACHINE_DOCKER_IP_ADDRESS
                port = 22
            }
        }
        inline = {
            prometheus = [
                "cat <<EOF > /tmp/prometheus.yml",
                "${local.template.prometheus}",
                "EOF",
                "cp -p /tmp/prometheus.yml /home/${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}/prometheus.yml",
                "chown ${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}:${var.VIRTUAL_MACHINE_GLOBAL_USERNAME} /home/${var.VIRTUAL_MACHINE_GLOBAL_USERNAME}/prometheus.yml",
                "rm -rf /tmp/prometheus.yml",
            ]
        }   
    }
}