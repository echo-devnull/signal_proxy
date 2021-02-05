##
# The ip address associated with the signal proxy

output "instance_ip_addr" {
  value = scaleway_instance_server.signal_proxy_server.public_ip
}
