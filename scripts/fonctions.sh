#!/bin/bash

# --- BASH QUEST : Bibliothèque de Fonctions Utilitaires ---


# --- Fonction PAUSE ---
# Utilise la commande 'sleep' pour temporiser l'affichage
# 0.3 seconde offre un bon compromis pour le rythme
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