#!/bin/bash
# Script de conversion d'un bloc de lignes Assertions.assert* vers un bloc Assertions.assertAll pour JUnit5

tmpfile=${1:-~/data.txt}

# TODO : handle comments //

# Supprimer la dernière virgule
sed -i "$ s/.$//" "${tmpfile}"

# Remplacer tous les ; de fin de ligne par une virgule
sed -i "s/);$/),/g" "${tmpfile}"

# Ajouter () -> devant chaque ligne (en ignorant les lignes vides)
sed -i '/^[[:space:]]*$/!s/^[[:space:]]*/() -> /g' "${tmpfile}"

# Ajouter assertAll au début
sed -i "1iAssertions.assertAll(" "${tmpfile}"

# Ajouter ); à la fin
echo ");" >> "${tmpfile}"
