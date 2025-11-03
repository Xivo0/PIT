#!/bin/bash

# --- Fonction PAUSE ---
function pause() {
    sleep 1 
}

# --- Fonction LIRE_PV ---
# Lit la partie 'actuelle' (avant le '/') d'un PV au format X/X
function lire_pv() {
    # $1 est le chemin du fichier (ex: DONJON/stats/hp_current)
    # $2 est le séparateur (par défaut '/')
    
    # 'cat $1' lit le contenu
    # '| cut -d"$2" -f1' envoie la sortie à 'cut'
    # -d"$2" : utilise le séparateur donné (ici '/')
    # -f1 : sélectionne le premier champ
    cat "$1" | cut -d"${2:-/}" -f1
}

# --- Fonction CHECK_MORT ---
# Vérifie si le joueur est mort (PV <= 0) et gère l'écran Game Over.
function check_mort() {
    # On doit redéfinir STATS_DIR ici car la fonction ne le connaît pas
    local STATS_DIR=$(dirname "$0")/../DONJON/stats
    
    # On lit la valeur ACTUELLE dans le fichier
    local HP_CURRENT=$(lire_pv "$STATS_DIR/PV_STATS")
    
    if [ "$HP_CURRENT" -le 0 ]; then
        echo "Aïe... Vous êtes mort."
        pause
        echo "---------------------"
        echo "Game Over. Lancez ./reset.sh et ./install.sh pour recommencer."
        exit 1 # <-- Ceci arrête le script appelant (ex: attaquer)
    fi
}

# --- Fonction LIRE_PV_MAX ---
# Lit la partie 'max' (après le '/') d'un PV au format X/Y
function lire_pv_max() {
    # $1 est le chemin du fichier (ex: DONJON/stats/PV_STATS)
    # $2 est le séparateur (par défaut '/')
    
    # cut -f2 sélectionne le deuxième champ (le MAX)
    cat "$1" | cut -d"${2:-/}" -f2
}

# --- Fonction ECRIRE_PV ---
# Met à jour la partie 'actuelle' (X) des PV/PE et maintient le MAX (Y)
# $1: Chemin du fichier de stats (ex: DONJON/stats/PV_STATS)
# $2: Nouvelle valeur de PV/PE actuelle
# $3: Séparateur (par défaut '/')

function ecrire_pv() {
    local STATS_FILE="$1"
    local NOUVELLE_VALEUR="$2"
    local SEPARATEUR="${3:-/}"
    
    # 1. On lit les PV/PE MAX (le champ 2)
    local MAX_VALEUR=$(lire_pv_max "$STATS_FILE" "$SEPARATEUR")

    # 2. On écrit la nouvelle valeur (X/Y) dans le fichier
    echo "$NOUVELLE_VALEUR$SEPARATEUR$MAX_VALEUR" > "$STATS_FILE"
}