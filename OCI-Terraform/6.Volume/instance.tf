resource "oci_core_instance" "test_instance" {
  availability_domain = "TnDu:AP-MUMBAI-1-AD-1"
  compartment_id      = "${var.compartment_id}"
  shape               = "VM.Standard2.1"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.mypub1.id}"
  }
  fault_domain = "FAULT-DOMAIN-1"
  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhymyAJr5MkRfnTZP08JGvUlakI5Gc6n336+Ey+66Pim5W8JlvFjt1nwz4Ca1jbbKVLesULnRfGJmYsBsuSJRLgwrrCTEdusQaWXF/UTQanaYR7+lT7B7QwSp9w/PEe2h6O4aopw3ztfL0+gqGIOop9CtEwgij/VbY5LBzpQYSjTHvFVonzOsY4ifBpwq3oc2CBtzdg+xEbTd13xk6IsOStos7xh9UWOPkK8HunwKc8fcqjJXx/O0H3MEg/shTtZN066HQumf6iyLvR63DPDNpvGl1MC0B1ooFYnBpEygMPzwTbW/rA5WwaxvZiBApmivIUMi16u/dMiV4gFocDqBew=="
    user_data           = "${base64encode(file("./userdata/bootstrap.sh"))}"
  }
  source_details {
    source_id               = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaiwrlleoggcmmugbuogn3wfqj7bgqc2abfkox6aypoudgs5oji3xa"
    source_type             = "image"
    boot_volume_size_in_gbs = 100
  }
  preserve_boot_volume = false
}