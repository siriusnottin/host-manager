#!/usr/bin/env bash

users_help() {
  echo "Aide sur les utilisateurs :"
  echo "1. Lister les utilisateurs humains du système."
  echo "2. Créer un nouvel utilisateur."
  echo "3. Modifier un utilisateur."
}

clear
users_help

echo "Appuyez sur une touche pour continuer..."
read -n 1 -s

source $SCRIPT_PATH/src/help/help_menu.sh
