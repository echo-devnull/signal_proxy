##
# Security group / firewall

resource "scaleway_instance_security_group" "signal_firewall" {
  name                    = "signal_firewall"
  description             = "Allows incoming traffic for just the signal proxy"
  external_rules          = true
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
}

# Allow these ports to be accessible from the world
locals {
  world_ports = [
    "80",
    "443"
  ]
}
# Allow the world to access these ports
resource "scaleway_instance_security_group_rules" "allow_world_ports" {
  security_group_id = scaleway_instance_security_group.signal_firewall.id

  dynamic "inbound_rule" {
    for_each = local.world_ports
    content {
      action   = "accept"
      ip_range = "0.0.0.0/0"
      port     = inbound_rule.value
      protocol = "TCP"
    }
  }
}


# Allow ssh access from certain ip's
locals {
  ssh_trusted = [
    "92.109.104.6"
  ]
}
resource "scaleway_instance_security_group_rules" "ssh" {
  security_group_id = scaleway_instance_security_group.signal_firewall.id

  dynamic "inbound_rule" {
    for_each = local.ssh_trusted
    content {
      action   = "accept"
      ip       = inbound_rule.value
      port     = 22
      protocol = "TCP"
    }
  }
}