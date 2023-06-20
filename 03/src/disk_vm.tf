resource "yandex_compute_disk" "hdd" {
    count = 3
    name     = "disk-name-${count.index}"
    type     = "network-hdd"
    size = 1
}
resource "yandex_compute_instance" "storage" {
    name        = "storage"
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
    dynamic secondary_disk {
        for_each    = yandex_compute_disk.hdd.*.id
    content {
      disk_id   = secondary_disk.value
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
}