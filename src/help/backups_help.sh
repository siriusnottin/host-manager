#!/usr/bin/env bash

# Help information related to backups

backups_help() {
  echo "Aide sur les sauvegardes :"
  echo "La fonctionnalité de sauvegarde, permet de sauvegarder les dossiers personnels des utilisateurs du système."
}

clear
backups_help

echo "Appuyez sur une touche pour continuer..."
read -n 1 -s

source $SCRIPT_PATH/src/help/help_menu.sh
