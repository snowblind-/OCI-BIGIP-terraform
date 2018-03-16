resource "null_resource" "BIGIP131" {
  provisioner "file" {
    source = "/root/.ssh/id_rsa.pub",
    destination = "/home/admin/.ssh/authorized_keys",
    connection {
      user = "root"
      password = "default"
      host = "${oci_core_instance.BIGIP131.public_ip}"
      timeout = "360s"
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 60s",
      "tmsh modify sys global-settings gui-setup disabled",
      "tmsh modify sys global hostname BIGIP131.f5.local",
      "tmsh modify sys http auth-pam-validate-ip off",
      "tmsh modify sys db systemauth.disablerootlogin value true",
      "tmsh modify auth user admin { password ${var.adminpwd} }",
      "tmsh modify auth user admin shell bash",
      "tmsh modify sys dns name-servers add { 169.254.169.254 8.8.8.8 }",
      "tmsh modify sys ntp timezone America/Los_Angeles",
      "tmsh modify sys ntp servers add { 0.north-america.pool.ntp.org }",
      "tmsh install sys license registration-key ${var.VE1Lic}",
      "sleep 60s",
      "tmsh save sys config partitions all",
    ]
    connection {
       user = "root"
       password = "default"
       host = "${oci_core_instance.BIGIP131.public_ip}"
       timeout = "360s"
    }
  }
}
