resource sakuracloud_note "note" {
    name = "${var.name}"
    content = "${template_file.script.rendered}"
}

resource "template_file" "script" {
    template = "${file("${path.module}/lb_dsr.sh")}"
    vars {
        vip = "${var.vip}"
    }
}