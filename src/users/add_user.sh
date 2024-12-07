#!/usr/bin/env bash

add_un_utilisateur() {
  # ont prévient que l'utilisateur doit passe en root avec un sudo
  #echo "pour ajoute un utilisateur il faudra passer en root en utilisant la commande sudo "

  read -p "Entrez le noms d'utilisateur : " USERNAME
  # ont verifie si le noms d'utilisateur est disponible/existe deja
  if id "$USERNAME" &>/dev/null; then
    echo " l'utilisateur $USERNAME exit deja "
  fi

  # ont demande le mots de passe a l'utilisateur
  read -s -p " Entrez le mots de passe pour $USERNAME :" Passwd
  echo " "

  #ont demande le goupe principal
  read -p " Veulliez entrez le groupe principale pour l'utilisateur $USERNAME :" Groupe

  if ! getent group "$Groupe" &>/dev/null; then
    echo "Le groupe '$Groupe' n'existe pas. Voulez-vous le créer ? (YES/NO)"
    read choix
    if [ "$choix" == "YES" ]; then
      groupadd "$Groupe"
      echo "Groupe '$Groupe' créé avec succès."
    else
      echo "Annulation de l'ajout de l'utilisateur."
      source users-menu.sh
    fi
  fi

  useradd -m -g "$Groupe" "$USERNAME"

  # Ajouter le mot de passe à l'utilisateur
  echo "$USERNAME:$Passwd" | chpasswd

  echo "Utilisateur '$USERNAME' ajouté avec succès au groupe '$Groupe'."

  echo "pour retournéee au menu "gestion des utilisateur " entée "1" "
  read choix
  if [ "$choix" -eq 1 ]; then
    source users-menu.sh
  else
    echo "Choix invalide. Retour au menu principal..."
    source host-manager.sh
  fi
}
