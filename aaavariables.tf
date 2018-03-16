// OCI Credentials 

variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

variable "fingerprint" {
  default = "ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff"
}

// API private key
variable "private_key_path" {
  default = "/root/bmcs_apiPrivateUnencrypted.pem"
}

variable "user_ocid" {
  default = "ocid1.user.oc1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

variable "compartment_ocid" {
  default = "ocid1.compartment.oc1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}
variable "region" {
  default = "us-phoenix-1"
}

// F5 BIGIP Admin Password
variable "adminpwd" {
  default = "p@55w3rD123"
}

// F5 BIGIP Licenses

variable "VE1Lic" {
  default = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXXXX"
}

variable "VE2Lic" {
  default = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXXXX"
}

//variable "VE1AD" {
//    default = "3"
//}

// VM.Standard1.8
// VM.Standard1.4
// VM.Standard1.1

// BIG-IP VE Instance Shape
variable "InstanceShape" {
    default = "VM.Standard1.8"
}

// BIG-IP Custom Image To Use In Deployment
variable "image" {
  default = "ocid1.image.oc1.phx.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

// Cloud-init scripts if any
variable "BootStrapFile" {
    default = "./userdata/veBoot.sh"
}

// admin user allowed ssh key

variable "ssh_public_key" {
  default = "ssh-rsa AAAA"
}

// admin user private key location (for remote terraform ssh functions)

variable "ssh_private_key" {
  default = "../.ssh/id_rsa"
}
