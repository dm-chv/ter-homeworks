################################################
#      Vars first VM            ################
################################################


##yandex_compute_instance
#-----------------------------------------------
variable "vm_web_name" {
  type = string
  description = "any name for VM"
  default = "netology-develop-platform-web"

}


variable "vm_web_platform_id" {
  type = string
  description = "platform id"
  default = "standard-v1"
}
#-----------------------------------------------

# variable "vm_web_p_resources" {
#   type = list
#   description = "cores, memory, core_fraction"
#   default = [2,1,5]
# }

variable "vm_web_resources" {
type=map
default= {
cpu =2
ram = 1
core_fraction = 5
}
}


# variable "vm_web_resources" {
#   type = map(object({
#     cores = string 
#     memory = string 
#     core_fraction = string   
#   }
#   ))
#   default = {cores = 2, memeory = 1, core_fraction = 5}
#   # default = {
#   #   cores = 2
#   #   memory = 1 
#   #   core_fraction = 20
#   # }
# }

#
################################################
#         END first VM vars                    #
################################################

################################################
#      Vars second VM            ################
################################################
#
#
##yandex_compute_instance
#-----------------------------------------------
variable "vm_db_name" {
  type = string
  description = "any name for VM"
  default = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type = string
  description = "platform id"
  default = "standard-v1"
}
#-----------------------------------------------

variable "vm_db_resources" {
  type=map
  default= {
  cpu =2
  ram = 2
  core_fraction = 20
}
}
# variable "vm_db_p_resources" {
#   type = list
#   description = "cores, memory, core_fraction"
#   default = [2,2,20]
# }
#
################################################
#         END second VM vars                    #
################################################

####METADATA############
variable "metadata" {
  type=map
  default= {
  serialP = 1
  ssh = "ubuntu:/home/pixel/.ssh/id_rsa.pub"
  }
}