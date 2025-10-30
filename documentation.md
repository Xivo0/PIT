# 🕹️ BASH QUEST : Le Dungeon Crawler en Shell

Ce document explique les principes et commandes du mini-jeu BASH QUEST, un *Rogue-like* entièrement codé en scripts Shell et utilisant la navigation de l'OS (système de fichiers) comme moteur de jeu.

---

## I. Principe du Jeu (Dungeon Crawling)

Le joueur incarne un aventurier (Guerrier, Mage, ou Voleur) et progresse à travers un donjon représenté par une arborescence de répertoires.

* **Une Salle** est un **répertoire** (`DONJON/salles/salle_X`).
* **Les Ennemis** et **Objets** sont des **fichiers** dans ces répertoires (ex: `squelette`, `coffre.txt`).
* **Le But** : Vaincre tous les ennemis d'une salle pour déverrouiller la porte et avancer.

### Palier de Difficulté

Le donjon est généré dynamiquement jusqu'à un maximum de **3 salles normales** par palier, après quoi le joueur rencontrera un **BOSS_FINAL**.

---

## II. Démarrage et Commandes Essentielles

### Installation et Lancement

1.  **Démarrage :** Lancer `./install.sh` et choisir sa classe.
2.  **Configuration de l'environnement :** Exécuter la commande affichée à la fin de l'installation pour ajouter les commandes du jeu au PATH et entrer dans le donjon :
    ```bash
    export PATH=$(pwd)/scripts:$PATH && cd DONJON/salles/entree
    ```

### Commandes de Navigation et d'Information

| Commande | Usage | Description / Commande Unix utilisée |
| :--- | :--- | :--- |
| `ls -A` | `ls -A` | Affiche les ennemis, objets et portes dans la salle actuelle (répertoire). |
| `cd ..` | `cd ..` | Permet de sortir du donjon ou de naviguer entre les salles. |
| `statut` | `statut` | **Affiche les PV/PE** et les statistiques de base du joueur. (Utilise `cat` et `cut` sur les fichiers de stats). |
| `regarder <cible>` | `regarder squelette` | Inspecte l'état d'un ennemi ou d'un objet (`cat`). |
| `inventaire` | `inventaire` | Liste les objets possédés. (Utilise `cat`, `sort` et `uniq -c`). |
| `grimoire` | `grimoire` | Liste les sorts connus. |

---

## III. Commandes de Gameplay (Tour par Tour)

Le combat se déclenche dès la première attaque et ne se termine que lorsque tous les ennemis de la salle sont vaincus (le fichier `etat_combat` est supprimé).

### A. Combat et Magie

| Commande | Rôle | Détail de la mécanique |
| :--- | :--- | :--- |
| `attaquer <ennemi>` | Attaque physique. | Inflige des dégâts. Si l'ennemi survit, il riposte (avec chance d'esquive du joueur). |
| `lancer_sort <sort> [cible]` | Lance un sort (Magie). | Consomme des PE. Les sorts offensifs attaquent, les sorts défensifs soignent (coûte toujours un tour, avec riposte en combat). |
| `fuir` | Tenter de quitter le combat. | 50% de chance de réussite. Si la fuite réussit, les **PV de tous les ennemis sont réinitialisés**. Échec = riposte ennemie. |
| `apprendre_sort <mot_clé>` | Apprendre un nouveau sort. | Doit correspondre à un mot-clé trouvé dans un indice (`cat` et `grep`). |

### B. Objets et Progression

| Commande | Rôle | Détail de la mécanique |
| :--- | :--- | :--- |
| `ouvrir <coffre.txt>` | Ouvrir un conteneur. | Peut donner une potion, un indice magique, ou déclencher un **piège** (dégâts aléatoires). |
| `ramasser <objet.item>` | Ramasser un objet. | Lit le contenu du fichier pour l'ajouter à l'inventaire. Nécessite que le gardien (si trésor `.loot`) soit vaincu. |
| `utiliser <potion_soin>` | Utiliser un objet. | Applique l'effet (soin, amélioration de stat). Si en combat, déclenche une riposte. |
| `porte_suivante` | Avancer de salle. | S'exécute uniquement si la salle est vide (le script se supprime après usage, empêchant la triche par la génération infinie de salles). |

---

## IV. Exigences Satisfaites

| Exigence | Statut | Détail de l'implémentation |
| :--- | :--- | :--- |
| **Utilisation d'Unix** | ✅ **Très Élevé** | Utilisation intensive de `cd`, `ls`, `cat`, `rm`, `grep`, `sed`, `cut`, `while read` pour simuler le monde et les mécaniques de jeu. |
| **Rejouable** | ✅ Oui | Le script `reset.sh` permet de supprimer le donjon et relancer une partie complète via `install.sh`. |
| **Complexité** | ✅ Satisfaite | Gestion des PV/PE au format X/Y, logique de groupe de combat, aléatoire (`$RANDOM`) et système d'énigmes/indices. |
