#!/usr/bin/env bash

modif_passwd() {
  read -p "Entrez le nom de l'utilisateur à modifier : " Username

  # ont vérifie si l'utilisateur existe et si il existe pas ont renvoie au menu utilisateur
  if ! id "$Username" &>/dev/null; then
    echo "L'utilisateur '$Username' n'existe pas."
    source sous_menu_modif_utilisateur
  else
    read -s -p "Entrez le nouveau mot de passe : " News_Passwd
    echo ""
    echo "$Username:$News_Passwd" | chpasswd
    echo "Le mot de passe de l'utilisateur '$Username' a été changé."
    source sous_menu_modif_utilisateur
  fi
}
