#!/usr/bin/env bash

# Configure network settings

INTERFACE=$1
IP_ADDRESS=$2
SUBNET_MASK=$3
GATEWAY=$4
DNS=$5

if [ -z "$INTERFACE" ] || [ -z "$IP_ADDRESS" ] || [ -z "$SUBNET_MASK" ] || [ -z "$GATEWAY" ] || [ -z "$DNS" ]; then
  echo "Usage: $0 <interface> <ip_address> <subnet_mask> <gateway> <dns>"
  exit 1
fi

sudo ip addr add $IP_ADDRESS/$SUBNET_MASK dev $INTERFACE
sudo ip route add default via $GATEWAY
echo "nameserver $DNS" | sudo tee /etc/resolv.conf >/dev/null
sudo systemctl restart networking
echo "Network settings configured for $INTERFACE"
