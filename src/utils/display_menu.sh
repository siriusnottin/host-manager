#!/usr/bin/env bash

# Display a menu with a title and options
# Usage: display_menu "Title" "Option 1" "Option 2" "Option 3" ...
display_menu() {
  local title=$1
  shift
  local options=("$@")

  while true; do
    echo -e "\n============================"
    echo -e "  $title"
    echo -e "============================\n"
    REPLY= # Reset REPLY
    PS3="Veuillez sélectionner une option : "
    select opt in "${options[@]}" "Quitter"; do
      if ((REPLY == 1 + ${#options[@]})); then
        echo "Sortie..."
        exit 0
      elif ((REPLY > 0 && REPLY <= ${#options[@]})); then
        echo "Vous avez sélectionné l'option $REPLY : $opt"
        break
      else
        echo "Option invalide. Essayez une autre option."
      fi
    done
    break
  done
}
