#!/usr/bin/env bash

function menu_gestion_users() {
  clear
  echo "                             "
  echo "   Gestion des utilisateur   "
  echo "                             "
  echo "  1.lister les utilisateur   "
  echo "                             "
  echo "  2.ajouté un utilsateur     "
  echo "                             "
  echo "  3.modifier un utilisateur  "
  echo "                             "
  echo "  4.Quitter le Menu          "
  echo "                             "
  echo "veulliez choisir une options : "
}

while true; do
  menu_gestion_users
  read -r choix

  case "$choix" in

  1)
    echo "Vous avez choisi de lister les utilisateur"
    exit 0
    ;;

  2)
    echo "Vous avez choisi d'ajouté un utilsateur"
    exit 0
    ;;
  3)
    echo "Vous avez choisi de modifier un utilisateur"
    exit 0
    ;;
  4)
    echo "Vous avez choisi de Quitter le Menu "
    exit 0
    ;;

  *)
    echo " options invalide , veulliez réessayer."
    exit 0
    ;;
  esac
done
