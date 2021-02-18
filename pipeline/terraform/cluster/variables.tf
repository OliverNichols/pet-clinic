# location variable 
variable "location" {
  description = "Region where the cluster is located"
  default = "UK South"
}

// project name 
variable "project_name" {
    default = "pet-clinic"
}

// VM Size 
variable "vm_size" {
    default = "Standard_D2_v2"
  
}


variable "serviceprinciple_id" {
  
}

variable "serviceprinciple_key" {
  
}

variable "kubernetes_version" {
    default = "1.19.7"
}

variable "ssh_key" {
  
}