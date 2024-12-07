#!/usr/bin/env bash
function sous_menu_logiciels() {
    clear
    echo " "
    echo "       Menu logiciels           " 
    echo " "
    echo "  1. liste des logiciels instalés "
    echo " "
    echo "  2. insataller un logiciel  "
    echo " "
    echo "  3. delete un logiciel   "
    echo " "
    echo " 4.Quitter le Menu  "
    echo " "
    echo "veulliez choisir une options : "
}   
while true; do
    menu_principal
    read -r choix

    case "$choix" in

        1)
            echo "Vous avez choisi liste des logiciels instalés"
            source liste_des_logiciel()
            ;; 
        2)
            echo "Vous avez choisi insataller un logiciel"
            source dl_logiciel()
            ;;
        3)
            echo "Vous avez choisi delete un logiciel"
            source supprimer_logiciel()
            ;;
        4)
                echo "Au revoir !"
            source host-manager.sh
            ;;

        *)
            echo " options invalide , veulliez réessayer."
            source sous_menu_logiciel.sh
            ;;
    esac
done