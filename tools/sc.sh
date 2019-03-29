#!/bin/sh

RULE_ID=$1

while [ -z ${RULE_ID} ];
do
	read -r -p "Saisir l'ID de la regle ShellCheck. Exemple 1100 : " RULE_ID
done

gio open "https://github.com/koalaman/shellcheck/wiki/SC${RULE_ID}"&
