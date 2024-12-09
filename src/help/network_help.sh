#!/usr/bin/env bash

network_help() {
  echo "Aide sur le réseau :"
  echo "1. Afficher les informations des interfaces réseau."
  echo "2. Configurer les paramètres réseau."
}

clear
network_help

echo "Appuyez sur une touche pour continuer..."
read -n 1 -s

source $SCRIPT_PATH/src/help/help_menu.sh
