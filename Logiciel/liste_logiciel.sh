#!/usr/bin/env bash


liste_des_logiciel(){
    echo "liste des logiciel "
    if [ -f /etc/os-release ]; then
# Identifier la distribution
    . /etc/os-release
        case $ID in

            ubuntu|debian)
                echo "Liste des logiciels installés sur Debian/Ubuntu:"
                dpkg --get-selections | grep -v deinstall
                ;;
            rhel|centos|fedora)
                echo "Liste des logiciels installés sur RHEL/CentOS/Fedora:"
                rpm -qa
                ;;
            arch|manjaro)
                echo "Liste des logiciels installés sur Arch/Manjaro:"
                pacman -Q
                ;;
            *)
                echo "Distribution non reconnue ou non prise en charge."
                source sous_menu_logiciel.sh
                ;;
        esac
    else
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
    
    echo "pour retournéee au menu "gestion des logiciel " entée 1 "
    read -r choix 
    if [ "$choix" -eq 1 ]; then 
        source sous_menu_logiciel.sh
    else
        echo "Choix invalide. Retour au menu principal..."
        source host-manager.sh
    fi

}