resource "oci_core_instance" "BIGIP132" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "VE-BIGIP132"
  image = "${var.image}"
  shape = "${var.InstanceShape}"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.WebSubnetAD1.id}"
  }
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.BootStrapFile))}"
  }
  timeouts {
    create = "60m"
  }
}

output "VE2PrimaryIPAddresses" {
  value = ["${oci_core_instance.BIGIP132.public_ip}",
           "${oci_core_instance.BIGIP132.private_ip}"]
}

