#!/bin/bash

# --- Script de Réinitialisation ---
# Supprime le donjon pour recommencer à zéro.

# SÉCURITÉ IMPORTANTE :
# Se déplace à l'endroit où se trouve ce script.
# (Ex: /home/xavier/mon_projet/)
# Cela évite les erreurs si on lance le reset en étant DANS le donjon.
cd "$(dirname "$0")"

echo "ATTENTION : Vous êtes sur le point de supprimer tout le donjon et votre progression."
read -p "Êtes-vous sûr de vouloir réinitialiser ? (o/n) " confirmation

# On vérifie la réponse (o ou O)
if [[ "$confirmation" == "o" || "$confirmation" == "O" ]]; then
  
    echo "Suppression du donjon..."
    
    # LA COMMANDE DE DESTRUCTION
    # -r = récursif (supprime les dossiers dans les dossiers)
    # -f = force (ne pose pas de question pour chaque fichier)
    rm -rf DONJON/
    
    echo "Donjon réinitialisé."
    echo "Vous pouvez lancer ./install.sh pour une nouvelle partie."

else
    echo "Annulation."
fi
