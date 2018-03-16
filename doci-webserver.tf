# OPTIONS: NOT COMPLETE
# BM.Standard1.36
# VM.Standard1.8
# VM.Standard1.4
#
variable "WSInstanceShape" {
    default = "VM.Standard1.4"
}

variable "WSInstanceOS" {
    default = "Oracle Linux"
}

variable "WSInstanceOSVersion" {
    default = "7.4"
}

variable "WSBootStrapFile" {
    default = "./userdata/bootstrapWS"
}

resource "oci_core_instance" "WebserverA" {
  depends_on = ["null_resource.BIGIP131"]
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "WebserverA"
  image = "ocid1.image.oc1.phx.aaaaaaaaxklzl52nmabfp3466ilzfpo7lv737k44kih4jpo7nsmxjehwrdsq"
  shape = "${var.WSInstanceShape}"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.WebSubnetAD3.id}"
  }
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.WSBootStrapFile))}"
  }
  timeouts {
    create = "60m"
  }
}

resource "oci_core_instance" "WebserverB" {
  depends_on = ["null_resource.BIGIP132"]
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "WebserverB"
  image = "ocid1.image.oc1.phx.aaaaaaaaxklzl52nmabfp3466ilzfpo7lv737k44kih4jpo7nsmxjehwrdsq"
  shape = "${var.WSInstanceShape}"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.WebSubnetAD3.id}"
  }
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.WSBootStrapFile))}"
  }
  timeouts {
    create = "60m"
  }
}


output "WSPrimaryIPAddresses" {
  value = ["${oci_core_instance.WebserverA.public_ip}",
           "${oci_core_instance.WebserverA.private_ip}",
           "${oci_core_instance.WebserverB.public_ip}",
           "${oci_core_instance.WebserverB.private_ip}",]
}
