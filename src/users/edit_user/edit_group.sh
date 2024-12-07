#!/usr/bin/env bash

modif_groupe_principal() {
  echo "modifie le groupe principale d'un utilisateur"

  read -p "Entrez le nom de l'utilisateur à modifier : " Username

  # ont vérifie si l'utilisateur existe et si il existe pas ont renvoie au menu utilisateur
  if ! id "$Username" &>/dev/null; then
    echo "L'utilisateur '$Username' n'existe pas."
    source sous_menu_modif_utilisateur
  else
    read -p "Entrez le nouveau groupe principal : " New_groupe
    if ! getent group "$New_groupe" &>/dev/null; then
      echo "Le groupe '$New_groupe' n'existe pas. Voulez-vous le créer ? (YES/NO)"
      read choix
      if [ "$choix" == "YES" ]; then
        groupadd "$New_groupe"
        echo "Groupe '$New_groupe' a bien etait crée ."
        usermod -g "$New_groupe" "$Username"
        echo "Le groupe principal de l'utilisateur '$Username' a été changé en '$New_groupe'."
      else
        echo "Annulation de l'ajout de l'utilisateur."
        source sous_menu_modif_utilisateur
      fi
    fi
  fi
}
