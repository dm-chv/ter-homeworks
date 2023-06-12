resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_name
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  #name        = local.web_name
  platform_id = var.vm_web_platform_id
  # resources {
  #   cores         = var.vm_web_p_resources[0]
  #   memory        = var.vm_web_p_resources[1]
  #   core_fraction = var.vm_web_p_resources[2]
  # }
    resources {
    cores         = var.vm_web_resources["cpu"]
    memory        = var.vm_web_resources["ram"]
    core_fraction = var.vm_web_resources["core_fraction"]
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

################################################
resource "yandex_compute_instance" "second_VM" {
  name        = var.vm_db_name
  #name        = local.db_name
  platform_id = var.vm_db_platform_id
  # resources {
  #   cores         = var.vm_db_p_resources[0]
  #   memory        = var.vm_db_p_resources[1]
  #   core_fraction = var.vm_db_p_resources[2]
  # }
  resources {
    cores         = var.vm_db_resources["cpu"]
    memory        = var.vm_db_resources["ram"]
    core_fraction = var.vm_db_resources["core_fraction"]
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
    serial-port-enable = var.metadata["serialP"]
    ssh-keys           = var.metadata["ssh"]
  }

}
