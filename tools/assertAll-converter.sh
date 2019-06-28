#!/bin/bash
# Script de conversion d'un bloc de lignes Assertions.assert* vers un bloc Assertions.assertAll pour JUnit5
# Utilisation :
#  - ouvrir un fichier texte (ex: ~/data.txt)
#  - copier-coller le bloc de code JUnit contenant toutes les lignes d'assertions
#  - sauvegarder le fichier puis lancer ce script avec ce fichier en paramètre
#  - ré-ouvrir (re-charger) le fichier et récupérer le résultat et le coller dans l'IDE

# fichier à traiter, soit le fichier passé en paramètre soit un fichier nommé data.txt dans le dossier home de l'utilisateur
readonly datafile=${1:-~/data.txt}

# TODO : handle comments //

# Suppression des espaces, tabulations, ... indésirables en début et fin ([[:space:]] -> [ \t\v\f] -> All whitespace chars)
sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' "${datafile}"

# Supprimer le dernier caractère ... qui doit être un point virgule
sed -i "$ s/.$//" "${datafile}"

# Remplacer tous les ; de fin de ligne par une virgule
sed -i "s/);$/),/g" "${datafile}"

# Ajouter () -> devant chaque ligne (en ignorant les lignes vides)
sed -i '/^[[:space:]]*$/!s/^[[:space:]]*/() -> /g' "${datafile}"

# Ajouter assertAll au début
sed -i "1iAssertions.assertAll(" "${datafile}"

# Ajouter ); à la fin
echo ");" >> "${datafile}"
