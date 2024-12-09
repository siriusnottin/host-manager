#!/usr/bin/env bash

software_help() {
  echo "Aide sur les logiciels :"
  echo "1. Lister les logiciels installés sur le système."
  echo "2. Installer un nouveau logiciel."
  echo "3. Désinstaller un logiciel existant."
}

clear
software_help

echo "Appuyez sur une touche pour continuer..."
read -n 1 -s

source $SCRIPT_PATH/src/help/help_menu.sh
