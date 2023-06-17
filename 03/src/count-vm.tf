resource "yandex_compute_instance" "develop" {
    count = 2
    name        = "develop-${count.index}"
    resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
    
  }
    boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}