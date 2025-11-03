# BASH QUEST 

Ce document explique les principes et commandes de BASH QUEST, un *Rogue-like* au gameplay tour par tour.

## Principe du Jeu

Le joueur incarne un aventurier (Guerrier, Mage, ou Voleur) et progresse à travers un donjon représenté par une arborescence de répertoires.

**Une Salle** est un **répertoire** (`DONJON/salles/salle_X`).
**Les Ennemis** et **Objets** sont des **fichiers** dans ces répertoires (ex: `squelette`, `coffre.txt`).
**Le But** : Vaincre tous les ennemis d'une salle pour déverrouiller la porte et avancer jusqu'au boss final.

### Palier de Difficulté

Le donjon est généré dynamiquement jusqu'à un maximum de **3 salles normales** sans compter l'entrée (nombre de salles ajustable dans le script generer_salle, ligne 19), après quoi le joueur rencontrera le **BOSS_FINAL**.

### Installation et Lancement

**Démarrage :** Lancer `./install.sh`, choisir sa classe et suivre les instructions pour arriver à l'entrée.

### Commandes de Navigation et d'Information

| Commande | Exemple | Description de la commande |

| `ls` | `ls` | Affiche les ennemis, objets et portes dans la salle actuelle (répertoire). |

| `cd <emplacement>` | `cd ..` pour revenir en arrière ou `cd salle_secrete` | Permet de sortir du donjon ou de naviguer entre les salles. |

| `statut` | `statut` | **Affiche les PV/PE** et les statistiques de base du joueur.

| `regarder <cible>` | `regarder squelette` | Inspecte l'état d'un ennemi ou d'un objet. |

| `inventaire` | `inventaire` | Liste les objets possédés. |

| `grimoire` | `grimoire` | Liste les sorts connus. |

## Commandes de Gameplay 

Le combat se déclenche dès la première attaque et ne se termine que lorsque tous les ennemis de la salle sont vaincus (le fichier `etat_combat` est supprimé).

### Combat et Magie

| Commande | Rôle/Exemple | Description de la commande/mécanique |

| `attaquer <ennemi>` | Attaque physique (basé sur la stat d'Attaque). | Inflige des dégâts. Si l'ennemi survit, il riposte (avec chance d'esquive du joueur, 25% de chance de base). |

| `lancer_sort <sort> [cible]` si offensif, sinon `lancer_sort <sort>`  | Lance un sort (basé sur la stat de Magie). | Consomme des PE. Les sorts offensifs attaquent, les sorts défensifs soignent (coûte toujours un tour, avec riposte en combat si ennemi survit, toujours avec chance d'esquive de 25% de chance). |

| `fuir` | Tenter de quitter le combat. | 50% de chance de réussite. Si la fuite réussit, les **PV de tous les ennemis sont réinitialisés**. Échec = riposte ennemie. |

| `apprendre_sort <formule>` | `apprendre_sort PATATE` | Permet d'ajouter un sort à son grimoire (soin de feu ou de soin) |


### Objets et Progression

| Commande | Exemple | Description de la commande |

| `ouvrir <coffre.txt>` | `ouvrir <coffre.txt>`  | Peut donner une potion, un indice magique, ou déclencher un piège (dégâts aléatoires). |

| `ramasser <objet.item>` ou `ramasser <objet.loot>` | `ramasser <cle_secrete.item>` | Ramasse objet et l'ajoute à l'inventaire. Nécessite que le gardien (si trésor `.loot`) soit vaincu. |

| `utiliser <objet>` | `utiliser potion_soin` | Applique l'effet (soin, amélioration de stat). Si en combat, déclenche une riposte de l'ennemi. |

| `./porte_X` | `./porte_suivante` | Génère la salle suivante si "porte_suivante" (il faut que tous les ennemis de la salle aient été vaincus), génère une salle secrète si "porte_secrete" (chances d'apparition: 50%) (si cle_secrete dans inventaire, chances d'apparition: 50%) |


## Divers

Le script `reset.sh` permet de supprimer le donjon et relancer une partie complète via `install.sh`. 

## Pour aller plus loin : 
-> ajouter un système de niveaux, permettre de faire en sorte que plus on avance plus l'ennemi nous fait très mal si on n'est pas bien équipé
-> permettre un dungeon crawling moins linéaire = + de salles par étage (par exemple, obtenir 3 clés pour pouvoir passer à l'étape suivante), actuellement, c'est seulement salle_n -> salle_n+1 -> salle_n+2 ...
-> réparer les éventuels bugs/exploits observés pour le moment (comme après avoir ramassé cle_secret.item, `touch cle_secret.item` la refait apparaître (même si on ne peut l'utiliser))
-> + de sorts, + d'équipements, + de monstres avec des caractéristiques uniques
-> ASCII arts ? ...

