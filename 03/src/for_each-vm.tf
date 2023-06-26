resource "yandex_compute_instance" "web" {
    # depends_on = [ yandex_compute_instance.develop]
    for_each = {
      first = {cpu = 2, ram = 4, disk = 5}
      second = {cpu = 4, ram = 8, disk = 10}
    }
    name        = "develop-${each.key}"
    resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
      boot_disk {
        initialize_params {
        image_id = data.yandex_compute_image.ubuntu.image_id
        type = "network-hdd"
       size = each.value.disk
    }
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
