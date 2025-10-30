#!/bin/bash

# --- Script d'Installation de BASH QUEST ---

echo "########################################"
echo "# Bienvenue dans BASH QUEST: Le Donjon #"
echo "########################################"
echo

# 1. Création de l'arborescence du "monde"
echo "Création du monde (DONJON)..."
mkdir -p DONJON/stats
mkdir -p DONJON/salles/entree

# 2. Choix de la classe
echo "Choisissez votre classe :"
echo "  [1] Guerrier (Robuste, frappe fort)"
echo "  [2] Mage     (Fragile, mais utilise la magie)"
echo "  [3] Voleur   (Équilibré, trouve plus d'objets)"
echo

read -p "Votre choix [1-3]: " choix_classe

# 3. Écriture des stats de base
stats_dir="DONJON/stats"

case $choix_classe in
  1) # Guerrier
    echo "Guerrier" > "$stats_dir/classe"
    echo "20/20" > "$stats_dir/PV_STATS"
    echo "5/5" > "$stats_dir/PE_STATS"
    echo "5" > "$stats_dir/attaque_base"
    echo "0" > "$stats_dir/magie_base"
    echo "1" > "$stats_dir/chance_loot"
    ;;
  2) # Mage
    echo "Mage" > "$stats_dir/classe"
    echo "12/12" > "$stats_dir/PV_STATS"
    echo "15/15" > "$stats_dir/PE_STATS"
    echo "2" > "$stats_dir/attaque_base"
    echo "6" > "$stats_dir/magie_base"
    echo "1" > "$stats_dir/chance_loot"
    echo "sort_feu" > "$stats_dir/grimoire.txt"
    ;;
  3) # Voleur
    echo "Voleur" > "$stats_dir/classe"
    echo "15/15" > "$stats_dir/PV_STATS"
    echo "10/10" > "$stats_dir/PE_STATS"
    echo "3" > "$stats_dir/attaque_base"
    echo "3" > "$stats_dir/magie_base"
    echo "3" > "$stats_dir/chance_loot"
    echo "potion_soin" > "$stats_dir/inventaire.txt"
    ;;
  *) # Défaut (Paysan)
    echo "Choix invalide. Vous serez un... Paysan."
    echo "Paysan" > "$stats_dir/classe"
    echo "10/10" > "$stats_dir/PV_STATS"
    echo "5/5" > "$stats_dir/PE_STATS"
    echo "1" > "$stats_dir/attaque_base"
    echo "0" > "$stats_dir/magie_base"
    echo "1" > "$stats_dir/chance_loot"
    ;;
esac

# 4. Création des fichiers d'inventaire (vides au besoin)
#    Garantit que ces fichiers existent pour toutes les classes.
touch "$stats_dir/inventaire.txt"
touch "$stats_dir/grimoire.txt"

# 5. Création de la première salle (l'entrée)
echo "Préparation de la première salle..."
salle_entree="DONJON/salles/entree"

# On écrit le message de bienvenue (avec un Here Document)
cat << EOF > "$salle_entree/message.txt"
Bienvenue dans le donjon.

Vous pouvez voir vos points de vie à tout moment avec la commande : statut

Devant vous se tient votre premier adversaire.
Pour l'inspecter, utilisez la commande : regarder <nom_de_l_ennemi>
Pour l'attaquer, utilisez la commande : attaquer <nom_de_l_ennemi>
EOF

# On place le premier ennemi (8 PV)
echo "8" > "$salle_entree/rat_chetif"
# On crée la première porte (avec la logique de verrouillage)
cat << EOF > "$salle_entree/porte_suivante"
#!/bin/bash
# --- Script de Porte Verrouillée ---
SALLE_ACTUELLE=\$(dirname "\$0")

# On compte les ennemis
# (J'ajoute 'rat_chetif' à la liste des ennemis à chercher)
NB_ENNEMIS=\$(ls -A "\$SALLE_ACTUELLE" | grep -E -c "(rat|gobelin|squelette|rat_mutant|rat_chetif)")

if [ "\$NB_ENNEMIS" -gt 0 ]; then
    echo "La porte est verrouillée. Il reste \$NB_ENNEMIS ennemi(s) :"
    ls -A "\$SALLE_ACTUELLE" | grep -E "(rat|gobelin|squelette|rat_mutant|rat_chetif)"
    exit 1
fi

echo "Vous avez nettoyé la salle. La porte se déverrouille..."
# On appelle le moteur de génération
exec "\$(dirname "\$0")/../../../scripts/generer_salle"
EOF

# On la rend exécutable
chmod +x "$salle_entree/porte_suivante"

echo "Personnage créé."

# 6. Instructions de départ
echo
echo "###################################################################"
echo "Votre aventure commence."
echo "Les commandes du jeu (statut, regarder, etc.) sont dans le dossier 'scripts/'."
echo
echo "Tapez la commande suivante pour commencer :"
echo
echo "  export PATH=\$(pwd)/scripts:\$PATH && cd DONJON/salles/entree"
echo
echo "###################################################################"
