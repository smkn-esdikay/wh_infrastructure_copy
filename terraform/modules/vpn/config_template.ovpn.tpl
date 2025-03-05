client
dev tun
proto udp
remote ${endpoint_url} 443
remote-random-hostname
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
verb 3

dhcp-option DNS ${dns_server}
%{ for domain in dns_domains ~}
dhcp-option DOMAIN ${domain}
%{ endfor ~}

# for internal DNS on linux, uncomment these lines. You may also need to install
# openvpn systemd resolved support: sudo apt install openvpn-systemd-resolved

# script-security 2
# up /etc/openvpn/update-systemd-resolved
# down /etc/openvpn/update-systemd-resolved


<ca>
${ca_data}
</ca>

<cert>
${crt_data}
</cert>

<key>
${key_data}
</key>

reneg-sec 0
