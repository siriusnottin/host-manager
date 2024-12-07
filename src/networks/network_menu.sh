#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# Network management menu

while true; do
  options=("Display network interfaces information" "Configure network settings" "Back to main menu")
  display_menu "Network Management" "${options[@]}"
  case $REPLY in
  1) "$SCRIPT_DIR/display-network-interfaces-infos.sh" ;;
  2)
    read -p "Enter interface: " interface
    read -p "Enter IP address: " ip_address
    read -p "Enter subnet mask: " subnet_mask
    read -p "Enter gateway: " gateway
    read -p "Enter DNS: " dns
    "$SCRIPT_DIR/configure-network-settings.sh" $interface $ip_address $subnet_mask $gateway $dns
    ;;
  3) break ;;
  *) echo "Invalid option. Try another one." ;;
  esac
done
