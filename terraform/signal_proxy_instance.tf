##
# Making sure my ssh key is available

# Getting public key contents
data "local_file" "ssh_contents" {
  filename = pathexpand("~/.ssh/id_ed25519.pub")
}

resource "scaleway_account_ssh_key" "signal_ssh_key" {
  name       = "signal_ssh_key"
  public_key = data.local_file.ssh_contents.content
  #   provider = "signal-proxy"
}


##
# Creating stardust instance

# Requesting a public ip
resource "scaleway_instance_ip" "signal_ip" {}

resource "scaleway_instance_server" "signal_proxy_server" {
  type              = "Stardust1-s"
  image             = "debian_stretch"
  ip_id             = scaleway_instance_ip.signal_ip.id
  name              = "signal_proxy"
  tags              = ["signal", "proxy"]
  state             = "started"
  security_group_id = scaleway_instance_security_group.signal_firewall.id
}

##
# Reverse DNS setup
# For when ip adress has been added to your DNS
resource "scaleway_instance_ip_reverse_dns" "reverse" {
  ip_id   = scaleway_instance_ip.signal_ip.id
  reverse = var.reverse_dns
}