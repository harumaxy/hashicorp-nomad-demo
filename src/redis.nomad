
job "redis" {
  datacenters = ["dc1"]
  type = "service"


  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }
  
  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }
  group "cache" {
    count = 2

    network {
      port "db" {
        to = 6379
      }
    }

    service {
      name     = "redis-cache"
      tags     = ["global", "cache"]
      port     = "db"
      provider = "nomad"
    }
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    // ephemeral_disk = 揮発性、同じ物理ホスト、高速だが停止するとデータが消える
    ephemeral_disk {
      // MB
      size = 300
    }

    
    task "redis" {
      driver = "docker"
      config {
        image = "redis:7"
        ports = ["db"]
        auth_soft_fail = true
      }

      resources {
        // -dev agent だと 合計1000MHz CPUリソースまで
        cpu    = 100 # MHz
        memory = 256 # MB
      }

      // hashicorp vault を使うとトークン、シークレットを自動で取得して使える
      // https://dev.classmethod.jp/articles/hashicorp-vault-basic-knowledge/
    }
  }
}
