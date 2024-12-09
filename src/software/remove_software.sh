#!/usr/bin/env bash

echo "Veuillez entrer le nom du logiciel que vous souhaitez supprimer :"
read -r logiciel

if [ -z "$logiciel" ]; then
    echo "Erreur : Aucun logiciel spécifié. Opération annulée."
    echo "Veuillez réessayer."
    source "$SCRIPT_PATH/src/software/remove_software.sh"
fi

echo "Vous avez demandé la suppression de $logiciel."

source "SCRIPT_PATH/src/utils/display_menu.sh"
# ask the user to confirm the software removal
options=("Oui" "Non")
display_menu "Voulez-vous vraiment supprimer $logiciel ?" "${options[@]}"
case $REPLY in
1) echo "Suppression de $logiciel..." ;;
2) echo "Suppression annulée." && source "$SCRIPT_PATH/src/software/software_menu.sh" ;;
*) echo "Option invalide. Suppression annulée." && source "$SCRIPT_PATH/src/software/software_menu.sh" ;;
esac

if [ -f /etc/os-release ]; then
    case $ID in
    ubuntu | debian)
        echo "Suppression de $logiciel sur Debian/Ubuntu..."
        sudo apt remove -y "$logiciel" && sudo apt autoremove -y
        ;;
    rhel | centos | fedora)
        echo "Suppression de $logiciel sur RHEL/CentOS/Fedora..."
        sudo dnf remove -y "$logiciel" || sudo yum remove -y "$logiciel"
        ;;
    arch | manjaro)
        echo "Suppression de $logiciel sur Arch/Manjaro..."
        sudo pacman -Rns --noconfirm "$logiciel"
        ;;
    *)
        echo "Distribution non reconnue ou non prise en charge."
        source "$SCRIPT_PATH/src/software/software_menu.sh"
        ;;
    esac
else
    echo "Impossible de détecter le système d'exploitation."
    source "$SCRIPT_PATH/src/software/software_menu.sh"
fi

echo "Le logiciel $logiciel a été supprimé avec succès."

source "$SCRIPT_PATH/src/utils/display_menu.sh"
options=("Supprimer un autre logiciel" "Retour au menu principal")
display_menu "Que voulez-vous faire ensuite ?" "${options[@]}"
case $REPLY in
1) source "$SCRIPT_PATH/src/software/remove_software.sh" ;;
2) source "$SCRIPT_PATH/host_manager.sh" ;;
*) echo "Option invalide. Retour au menu principal." && source "$SCRIPT_PATH/host_manager.sh" ;;
esac
