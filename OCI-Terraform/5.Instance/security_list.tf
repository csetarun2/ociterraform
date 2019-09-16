resource "oci_core_security_list" "test_security_list" {
    compartment_id="${var.compartment_id}"
    vcn_id="${oci_core_vcn.test_vcn.id}"
    display_name="${var.secldisplay_name}"
    ingress_security_rules {
        protocol="6"
        source="0.0.0.0/0"
        tcp_options {
                min=80
                max=80
        }
    }
    ingress_security_rules {
        protocol="6"
        source="0.0.0.0/0"
        tcp_options {
                min=22
                max=22
        }
    }
    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol="all"
    }

}