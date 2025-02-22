global:
  scrape_interval: 15s
  evaluation_interval: 15s
  
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["${VIRTUAL_MACHINE_DOCKER_IP_ADDRESS}:9090"]

  - job_name: "cadvisor"
    static_configs:
      - targets: ["${VIRTUAL_MACHINE_DOCKER_IP_ADDRESS}:8082"]

  - job_name: "docker"
    static_configs:
      - targets: ["${VIRTUAL_MACHINE_DOCKER_IP_ADDRESS}:9100"]