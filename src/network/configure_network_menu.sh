#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

get_network_interfaces() {
  ip link show | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}'
}

select_network_interface() {
  local interfaces=($(get_network_interfaces))
  local options=()
  for interface in "${interfaces[@]}"; do
    options+=("$interface")
  done
  display_menu "Select a network interface" "${options[@]}"
  INTERFACE=${interfaces[$REPLY - 1]}
}

edit_network_interface() {
  select_network_interface
  while true; do
    options=("Edit IP address" "Edit gateway" "Edit DNS" "Back to network management menu" "Back to main menu")
    display_menu "Edit network interface $INTERFACE" "${options[@]}"
    case $REPLY in
    1)
      read -p "Enter the IP address: " IP_ADDRESS
      read -p "Enter the subnet mask (default 24): " SUBNET_MASK

      SUBNET_MASK=${SUBNET_MASK:-24} # set default for subnet mask
      sudo ip addr add $IP_ADDRESS/$SUBNET_MASK dev $INTERFACE
      ;;
    2)
      read -p "Enter the gateway: " GATEWAY
      sudo ip route add default via $GATEWAY
      ;;
    3)
      read -p "Enter the DNS: " DNS
      echo "nameserver $DNS" | sudo tee /etc/resolv.conf >/dev/null
      ;;
    4) exit ;;
    5) source "$SCRIPT_PATH/host_manager.sh" ;;
    *) echo "Invalid option. Try another one." ;;
    esac
  done
}

reboot_system() {
  read -p "Do you want to reboot the system now? (y/N) " REBOOT
  if [ "$REBOOT" == "y" ]; then
    sudo reboot
  fi
}

edit_network_interface
reboot_system
