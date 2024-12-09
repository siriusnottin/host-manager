#!/usr/bin/env bash
clear
echo "liste des logiciel "
if [ -f /etc/os-release ]; then
    # Identifier la distribution
    . /etc/os-release
    case $ID in

    ubuntu | debian)
        echo "Liste des logiciels installés sur Debian/Ubuntu:"
        dpkg --get-selections | grep -v deinstall
        ;;
    rhel | centos | fedora)
        echo "Liste des logiciels installés sur RHEL/CentOS/Fedora:"
        rpm -qa
        ;;
    arch | manjaro)
        echo "Liste des logiciels installés sur Arch/Manjaro:"
        pacman -Q
        ;;
    *)
        echo "Distribution non reconnue ou non prise en charge."
        source sous_menu_logiciel.sh
        ;;
    esac
else
    clear
    echo "pas de logiciel installer sur la machine"
    echo ""
    echo "pour retournéee au menu "sous_menu_logiciel " entée 1 "
    read choix
    if [ "$choix" -eq 1 ]; then
        source sous_menu_logiciel.sh
    else
        echo "Choix invalide. Retour au menu principal..."
        source host-manager.sh
    fi
fi

source "$SCRIPT_PATH/src/utils/display_menu.sh"

while true; do
    options=("Installer un logiciel" "Désinstaller un logiciel" "Revenir au menu principal")
    display_menu "Gestion des logiciels" "${options[@]}"
    case $REPLY in
    1) source "$SCRIPT_PATH/src/software/install_software.sh" ;;
    2) source "$SCRIPT_PATH/src/software/remove_software.sh" ;;
    3) source "$SCRIPT_PATH/host_manager.sh" ;;
    *) echo "Option invalide, veuillez réessayer." ;;
    esac
done
