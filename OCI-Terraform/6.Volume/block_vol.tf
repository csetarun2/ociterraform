resource "oci_core_volume" "test_vol" {
  display_name        = "myvol"
  availability_domain = "TnDu:AP-MUMBAI-1-AD-1"
  compartment_id      = "${var.compartment_id}"
  size_in_gbs         = 55
}

resource "oci_core_volume_attachment" "test_vol" {
  attachment_type = "iscsi"
  instance_id     = "${oci_core_instance.test_instance.id}"
  volume_id       = "${oci_core_volume.test_vol.id}"
  display_name    = "Vol_Attachment"
  connection {
    type        = "ssh"
    host        = "${oci_core_instance.test_instance.public_ip}"
    user        = "opc"
    private_key = "${file("./key/tf.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo iscsiadm -m node -o new -T ${self.iqn} -p ${self.ipv4}:${self.port}",
      "sudo iscsiadm -m node -o update -T ${self.iqn} -n node.startup -v automatic",
      "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -l",
    ]
  }

  # initialize partition and file system
  provisioner "remote-exec" {
    inline = [
      "set -x",
      "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
      "export HAS_PARTITION=$(sudo partprobe -d -s /dev/disk/by-path/$${DEVICE_ID} | wc -l)",
      "if [ $HAS_PARTITION -eq 0 ] ; then",
      "  (echo n; echo ''; echo ''; echo ''; echo w) | sudo fdisk /dev/disk/by-path/$${DEVICE_ID}",
      "  (echo y; echo '';) | sudo mkfs.ext4 /dev/disk/by-path/$${DEVICE_ID}",
      "fi",
    ]
  }

  # mount the partition
  provisioner "remote-exec" {
    inline = [
      "set -x",
      "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
      "sudo mkdir -p /mnt/vol1",
      "export UUID=$(sudo blkid -s UUID -o value /dev/disk/by-path/$${DEVICE_ID})",
      "echo 'UUID='$${UUID}' /mnt/vol1 ext4 defaults,_netdev,nofail 0 2' | sudo tee -a /etc/fstab",
      "sudo mount -a",
    ]
  }

  # unmount and disconnect on destroy
  provisioner "remote-exec" {
    when       = "destroy"
    on_failure = "continue"
    inline = [
      "set -x",
      "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
      "export UUID=$(sudo /usr/sbin/blkid -s UUID -o value /dev/disk/by-path/$${DEVICE_ID})",
      "sudo umount /mnt/vol1",
      "if [[ $UUID ]] ; then",
      "  sudo sed -i.bak '\\@^UUID='$${UUID}'@d' /etc/fstab",
      "fi",
      "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -u",
      "sudo iscsiadm -m node -o delete -T ${self.iqn} -p ${self.ipv4}:${self.port}",
    ]
  }

}