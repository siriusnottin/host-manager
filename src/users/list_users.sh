#!/usr/bin/env bash

liste_des_utilisateur() {
  echo "liste des utilisateur "
  cut -d: -f1 /etc/passwd
  echo ""
  echo "pour retournéee au menu "gestion des utilisateur " entée 1 "
  read choix
  if [ "$choix" -eq 1 ]; then
    source users-menu.sh
  else
    echo "Choix invalide. Retour au menu principal..."
    source host-manager.sh
  fi
}
