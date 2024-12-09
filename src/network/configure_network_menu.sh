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
  display_menu "Sélectionnez une interface réseau" "${options[@]}"
  INTERFACE=${interfaces[$REPLY - 1]}
}

edit_network_interface() {
  clear
  select_network_interface
  while true; do
    options=("Modifier l'adresse IP" "Modifier la passerelle" "Modifier le DNS" "Retour au menu de gestion du réseau" "Retour au menu principal")
    display_menu "Modifier l'interface réseau $INTERFACE" "${options[@]}"
    case $REPLY in
    1)
      clear
      read -p "Entrez l'adresse IP : " IP_ADDRESS
      read -p "Entrez le masque de sous-réseau (par défaut 24) : " SUBNET_MASK

      SUBNET_MASK=${SUBNET_MASK:-24} # définir la valeur par défaut pour le masque de sous-réseau
      sudo ip addr add $IP_ADDRESS/$SUBNET_MASK dev $INTERFACE
      ;;
    2)
      clear
      read -p "Entrez la passerelle : " GATEWAY
      sudo ip route add default via $GATEWAY
      ;;
    3)
      clear
      read -p "Entrez le DNS : " DNS
      echo "nameserver $DNS" | sudo tee /etc/resolv.conf >/dev/null
      ;;
    4) exit ;;
    5) source "$SCRIPT_PATH/host_manager.sh" ;;
    *) echo "Option invalide. Essayez-en une autre." ;;
    esac
  done
}

reboot_system() {
  read -p "Voulez-vous redémarrer le système maintenant ? (y/N) " REBOOT
  if [ "$REBOOT" == "y" ]; then
    sudo reboot
  fi
}

edit_network_interface
reboot_system
