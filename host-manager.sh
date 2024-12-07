#!/usr/bin/env bash

function menu_principal() {
  clear
  echo "                             "
  echo "      Menu Principal         "
  echo "                             "
  echo "  1. Gestion des Utilisateur "
  echo "                             "
  echo "  2. Gestion des logiciels   "
  echo "                             "
  echo "  3. Gestion du Réseau       "
  echo "                             "
  echo "  4. Sauvegarde de dossier   "
  echo "                             "
  echo "  5. Gestion des Crontab     "
  echo "                             "
  echo "  6.Quitter le Menu          "
  echo "                             "
  echo "veulliez choisir une options : "
}

while true; do
  menu_principal
  read -r choix

  case "$choix" in

  1)
    echo "Vous avez choisi la gestion des utilisateurs"
    exit 0
    ;;

  2)
    echo "Vous avez choisi la gestion des logiciels"
    exit 0
    ;;
  3)
    echo "Vous avez choisi la gestion du réseau"
    exit 0
    ;;
  4)
    echo "Vous avez choisi la sauvegarde de dossier"
    exit 0
    ;;
  5)
    echo "Vous avez choisi la gestion des Crontab"
    exit 0
    ;;

  6)
    echo "Au revoir !"
    exit 0
    ;;

  *)
    echo " options invalide , veulliez réessayer."
    exit 0
    ;;
  esac
done
