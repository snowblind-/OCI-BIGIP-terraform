resource "null_resource" "BUILDVE2" {
  depends_on = ["oci_core_instance.WebserverB"]
  provisioner "remote-exec" {
    inline = [
      "tmsh create ltm pool webservers members add { ${oci_core_instance.WebserverA.private_ip}:http ${oci_core_instance.WebserverB.private_ip}:http } monitor tcp_half_open",
      "tmsh create ltm virtual vs { destination 0.0.0.0:http ip-protocol tcp mask any pool webservers profiles add { http { } tcp { } } source-address-translation { type automap } translate-address enabled }",
      "tmsh save sys config partitions all",
    ]
    connection {
       type = "ssh"
       user = "admin"
       private_key = "${file(var.ssh_private_key)}"
       host = "${oci_core_instance.BIGIP132.public_ip}"
       timeout = "60s"
    }
  }
}
