// hashicorp nomad
// batch job example
job "echo" {
  datacenters = ["dc1"]
  type = "batch"
  group "echo" {
    count = 1
    task "echo" {
      driver = "raw_exec"
      config {
        command = "echo"
        args = ["hello world"]
      }
      resources {
        cpu = 10
        memory = 10
      }
    }
  }
}
  