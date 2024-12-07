#!/usr/bin/env bash

modif_username() {
  read -p "Entrez le nom de l'utilisateur à modifier : " Username

  # ont vérifie si l'utilisateur existe et si il existe pas ont renvoie au menu utilisateur
  if ! id "$Username" &>/dev/null; then
    echo "L'utilisateur '$Username' n'existe pas."
    source sous_menu_modif_utilisateur
  else
    read -p "Entrez le nouveau nom de l'utilisateur : " New_Username
    usermod -l "$New_Username" "$Username"
    echo "Le nom de l'utilisateur a été changé en '$New_Username'."
  fi
}
