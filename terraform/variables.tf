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
// my free trial subscription id
variable "subscription_id" {
  default = "3e61aed4-4b76-44d4-9343-6979c9d282fd"
}

variable "serviceprinciple_id" {
  
}

variable "serviceprinciple_key" {
  
}

variable "tenant_id" {
  
}

variable "kubernetes_version" {
    default = "1.19.7"
}

variable "ssh_key" {

}

variable "resource_group" {
  
}
