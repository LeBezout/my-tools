#!/bin/bash
# -----------------------------------------------------------------------------------------------------------------------------
# Script de TODO
# AUTEUR : TODO
# Attention :
# - ce script nécessite la présence :
#    > de l'outil XXXX
#    > du script XXXX
# Execution :
#   MODE HELP : ./TODO.sh --help
#   MODE TEST : ./TODO.sh --test arg2 arg3
#   MODE REEL : ./TODO.sh arg1 arg2 arg3
# -----------------------------------------------------------------------------------------------------------------------------

# Appel du shell positionnant les variables liées à l'environnement courant
. /TODO/setenv.sh

# -----------------------------------------------------------------------------------------------------------------------------
# Définition des constantes [NORME: en majuscules]
# -----------------------------------------------------------------------------------------------------------------------------
# Prefixe de log
#LOG_PREFIX="TODO|"
# Nom du shell
readonly PROG_NAME=$(basename "$0")
# Dossier du shell
readonly PROG_HOME="$(cd $(dirname $0)/..; pwd)"
# Nom de la machine
readonly HOST_NAME=$(hostname)
# Informations du système (OS, host)
readonly SYSTEM_INFO=$(uname --all)
# Utilisateur exécutant le script
readonly USER=$(id -u -n)
# Chemin de l'executable java
readonly JAVA_PATH="/app/${env_host}/java/jdk1.8.0_131/bin/java"
# Options Java classiques
readonly JAVA_OPTS="-Xms128m -Xmx512m"
# Version Java (exemple 1.8.0_131)
readonly JAVA_VERSION=$(${JAVA_PATH} -version 2>&1 | grep 'java version' | tr -d \" | cut -d' ' -f3)

# -----------------------------------------------------------------------------------------------------------------------------
# Définition des fonctions [NORME: fXxxYyy]
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet d'afficher le mode d'appel du script
fDisplayUsage() {
	echo "Usage: $0 <param1> <param2> <param3>"
	echo "   <param1> : TODO [obligatoire]"
	echo "   <param2> : TODO [obligatoire]"
	echo "   <param3> : TODO [optionnel - XXX par defaut]"
	echo "-----------------------------------------------------------------------------------------------------------------------------"
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de tracer les informations concernant le contexte d'exécution du script
fDisplayContext() {
	echo "Contexte d'execution du script"
	echo "------------------------------------------------------------"
	echo " --- Le shell :"
	echo "  Nom=${PROG_NAME}"
	echo "  Path=$0"
	echo "  Executeur=${USER}"
	echo " --- L'hote :"
	echo "  System=${SYSTEM_INFO}"
	if [ -f "/etc/centos-release" ]; then
		echo "  OS=$(cat /etc/centos-release)"
	elif [ -f "/etc/redhat-release" ]; then
		echo "  OS=$(cat /etc/redhat-release)"
	fi
	echo "  Hostname=${HOST_NAME}"
	echo " --- L'environnement :"
	echo "  TODO"
	echo " --- Les middlewares :"
	echo "  TODO"
	echo " --- L'application :"
	echo "  TODO"
	echo "------------------------------------------------------------"
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction effectue un log sur la sortie standard du code retour puis fait la commande "exit"
# @param $1 le code retour
# @param $2 le message
fExitWithCode() {
	if [ $1 -eq 0 ]; then
		echo "$2"
	else
		echo "--        ECHEC : $2" 1>&2;
	fi
	echo "--  CODE RETOUR : $1"
	echo "-- HEURE DE FIN : $(date '+%G%m%d_%H%M_%S')"
	echo "-----------------------------------------------------------------------------------------------------------------------------"
  exit $1
}
# -----------------------------------------------------------------------------------------------------------------------------
# Définition des variables [NORME: en minuscules]
# -----------------------------------------------------------------------------------------------------------------------------

# TODO

# -----------------------------------------------------------------------------------------------------------------------------
# Aide du script
# -----------------------------------------------------------------------------------------------------------------------------
if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
	fDisplayUsage
	# Fin du mode --help : on sort
	exit 0
fi

# -----------------------------------------------------------------------------------------------------------------------------
# Corps du script
# -----------------------------------------------------------------------------------------------------------------------------
echo "-----------------------------------------------------------------------------------------------------------------------------"
echo "Demarrage de TODO_NOM_DU_SHELL"
echo "-- HEURE DE DEBUT : $(date '+%G%m%d_%H%M_%S')"
echo "-----------------------------------------------------------------------------------------------------------------------------"
fDisplayContext

# -----------------------------------------------------------------------------------------------------------------------------
# Dump des infos
# -----------------------------------------------------------------------------------------------------------------------------

# TODO

# -----------------------------------------------------------------------------------------------------------------------------
# Contrôle des arguments [EXIT CODES 1X]
# -----------------------------------------------------------------------------------------------------------------------------

# TODO

# Fin du mode --test pour juste vérifier les valeurs (qui semblent à priori correctes) : on sort
if [ "$1" = "--test" ]; then
	fExitWithCode 0 "FIN DU SCRIPT [$1]"
fi

# -----------------------------------------------------------------------------------------------------------------------------
# CORPS DU SCRIPT
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# FIN DU SCRIPT
# -----------------------------------------------------------------------------------------------------------------------------
fExitWithCode 0 "FIN DU SCRIPT"
