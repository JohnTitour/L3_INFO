#!/bin/bash

# Verification de la presence d'un dossier .corbeille dans le $HOME
# Si il n'existe pas on le creer
if [[ ! -d $HOME/.corbeille ]]
then
  mkdir $HOME/.corbeille
fi

# On verifie si il y a bien 2 argument a l'appel du programme
# 1er paramètre : la commande souhaitée (efface, restaure, info, vide)
# Autres paramètres : nom de fichier/dossier sur lequel on effectue la commande
if [[ $# -ge 2 ]]
then
  for p in ${@:2}
  do
    case $1 in
      efface)
        # Recuparation du path du fichier recherche dans le repertoire courant
        pos=$(find . -name $p)

        # On compte les nombre de caractere pour enlever le '.' au debut de $pos
        nbChar=${#pos}-1
        pathfile=$(echo $pos || tail -c $nbChar)
        mv $pathfile $HOME/.corbeille
        ;;

      restaure)
        # Recuparation du path du fichier recherche dans la corbeille
        pos=$(find $HOME/.corbeille/ -name $p)

        # On compte les nombre de caractere pour enlever le '.' au debut de $pos
        nbChar=${#pos}-1
        pathfile=$(echo $pos || tail -c $nbChar)
        mv $HOME/.corbeille/$p .
        ;;

      info)
        # On cherche si le fichier/dossier demandé est dans la corbeille
        # ou le repertoire courant
        if [[ -d $p ]]
        then
          ls -l $p
        elif [[ -d $HOME/.corbeille/$p ]]
        then
          ls -l $HOME/.corbeille/$p
        elif [[ -f $p ]]
        then
          ls -l $p
        elif [[ -f $HOME/.corbeille/$p ]]
        then
          ls -l $HOME/.corbeille/$p
        else
          echo "$p n'existe pas."
        fi
        ;;

      vide)
        rm $HOME/.corbeille/$p
        ;;
    esac
  done

# Si il n'y a qu'un seul argument et que la commande est 'vide'
# Alors on supprime tous les elements contenu dans $HOME/.corbeille
elif [[ ($# == 1) && ($1 == "vide") ]]; then
  cd $HOME/.corbeille/
  rm *
fi
