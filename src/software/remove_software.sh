la#!/usr/bin/env bash

supprimer_logiciel() {
    clear
    echo "Veuillez entrer le nom du logiciel que vous souhaitez supprimer :"
    read -r logiciel

    if [ -z "$logiciel" ]; then
        echo "Erreur : Aucun logiciel spécifié. Opération annulée."
        source sous_menu_logiciel.sh
    fi


    echo "Vous avez choisi de supprimer : $logiciel"
    echo "Êtes-vous sûr de vouloir continuer ? (o/N)"
    read -r confirmation


    # Convertir la réponse en minuscule pour éviter les erreurs

    confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')

    if [ "$confirmation" != "o" ]; then
        echo "Opération annulée."
        source sous_menu_logiciel.sh
    fi

    if [ -f /etc/os-release ]; then
        clear
# Identifier la distribution
        . /etc/os-release


        case $ID in

            ubuntu|debian)
                echo "Suppression de $logiciel sur Debian/Ubuntu..."
                sudo apt remove -y "$logiciel" && sudo apt autoremove -y
                ;;
            rhel|centos|fedora)
                echo "Suppression de $logiciel sur RHEL/CentOS/Fedora..."
                sudo dnf remove -y "$logiciel" || sudo yum remove -y "$logiciel"
                ;;
            arch|manjaro)
                echo "Suppression de $logiciel sur Arch/Manjaro..."
                sudo pacman -Rns --noconfirm "$logiciel"
            *)
                echo "Distribution non reconnue ou non prise en charge."
                source sous_menu_logiciel.sh
                ;;
        esac
    else
        clear
        echo "Impossible de détecter le système d'exploitation."
        source sous_menu
    fi

    clear
    echo "Le logiciel $logiciel a été supprimé avec succès."

    echo "pour retournéee au menu "gestion des logiciel " entée 1 "
    read -r choix 
    if [ "$choix" -eq 1 ]; then 
        source sous_menu_logiciel.sh
    else
        echo "Choix invalide. Retour au menu principal..."
        source host-manager.sh
    fi
}
