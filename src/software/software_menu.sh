#!/usr/bin/env bash

source "$SCRIPT_PATH/src/utils/display_menu.sh"

while true; do
  clear
  options=("Lister les logiciels installés" "Installer un logiciel" "Désinstaller un logiciel" "Afficher l'aide" "Revenir au menu principal")
  display_menu "Gestion des logiciels" "${options[@]}"
  case $REPLY in
  1) source "$SCRIPT_PATH/src/software/list_softwares.sh" ;;
  2) source "$SCRIPT_PATH/src/software/install_software.sh" ;;
  3) source "$SCRIPT_PATH/src/software/remove_software.sh" ;;
  4) source "$SCRIPT_PATH/src/help/software_help.sh" ;;
  5) source "$SCRIPT_PATH/host_manager.sh" ;;
  *) echo "Option invalide, veuillez réessayer." ;;
  esac
done
