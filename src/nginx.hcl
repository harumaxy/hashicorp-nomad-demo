job "httpd2" {
  datacenters = ["dc1"]
  type = "service"

  group "front" {
    count = 1
    network {
      port "http" {
        static = 80
      }
    }
    service {
      name = "nginx-httpd"
      port = "http"
    }
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    ephemeral_disk {
      size = 300
    }
    task "nginx" {
      driver = "docker"
      config {
        image = "nginx:latest"
        ports = ["http"]
        volumes = [
          "local/top.html:/usr/share/nginx/html/top.html",
        ]
      }
      resources {
        cpu    = 100 # 500 MHz
        memory = 256 # 256MB
      }

      template {
        change_mode = "noop"
        destination = "local/top.html"

        data = <<EOH
<h1>Welcome</h1>
EOH
      }

    }
  }
}