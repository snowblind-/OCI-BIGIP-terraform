# OPTIONS: NOT COMPLETE
# BM.Standard1.36
# VM.Standard1.8
# VM.Standard1.4
#
variable "ABInstanceShape" {
    default = "VM.Standard1.4"
}

variable "ABInstanceOS" {
    default = "Oracle Linux"
}

variable "ABInstanceOSVersion" {
    default = "7.4"
}

variable "ABBootStrapFile" {
    default = "./userdata/bootstrapAB"
}

resource "oci_core_instance" "ApacheBench" {
  depends_on = ["null_resource.BIGIP131"]
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "ApacheBench"
  image = "ocid1.image.oc1.phx.aaaaaaaaxklzl52nmabfp3466ilzfpo7lv737k44kih4jpo7nsmxjehwrdsq"
  shape = "${var.ABInstanceShape}"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.WebSubnetAD3.id}"
  }
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.ABBootStrapFile))}"
  }
  timeouts {
    create = "60m"
  }
}
output "ABPrimaryIPAddresses" {
  value = ["${oci_core_instance.ApacheBench.public_ip}",
           "${oci_core_instance.ApacheBench.private_ip}",]
}
