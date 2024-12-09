#!/usr/bin/env bash

crontabs_help() {
  echo "Aide sur les crontabs :"
  echo "1. Afficher les crontabs de l'utilisateur courant."
  echo "2. Afficher les crontabs d'un utilisateur spécifique."
  echo "3. Éditer les crontabs d'un utilisateur."
}

clear
crontabs_help

echo "Appuyez sur une touche pour continuer..."
read -n 1 -s

source $SCRIPT_PATH/src/help/help_menu.sh
