#!/usr/bin/env bash

# Display network interfaces informations
for interface in $(ls /sys/class/net/); do
  echo "Interface: $interface"
  ip addr show $interface | grep "inet\b" | awk '{print "IP Address: " $2}'
  cat /sys/class/net/$interface/address | awk '{print "MAC Address: " $1}'
  ip route | grep default | awk '{print "Gateway: " $3}'
  cat /etc/resolv.conf | grep nameserver | awk '{print "DNS: " $2}'
  cat /sys/class/net/$interface/operstate | awk '{print "Connection Status: " $1}'
  ethtool $interface 2>/dev/null | grep "Speed:" | awk '{print "Connection Speed: " $2}'
  echo ""
done
