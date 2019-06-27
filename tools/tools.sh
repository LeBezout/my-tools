#!/bin/bash
# Bibliothèque de fonctions utilitaires shell
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# CONSTANTS
# -----------------------------------------------------------------------------------------------------------------------------

readonly LOGLEVEL_OFF=0
readonly LOGLEVEL_DEBUG=1
readonly LOGLEVEL_INFO=2
readonly LOGLEVEL_WARN=3
readonly LOGLEVEL_ERROR=4

# -----------------------------------------------------------------------------------------------------------------------------
# CONFIGURATION
# -----------------------------------------------------------------------------------------------------------------------------

# Niveau de log à chsoir parmi LOGLEVEL_OFF, LOGLEVEL_DEBUG, LOGLEVEL_INFO, LOGLEVEL_WARN, LOGLEVEL_ERROR
readonly LOGLEVEL=$LOGLEVEL_INFO

# Paramètres d'accès au manager Tomcat
readonly TOMCAT_CURL_PARAMS="--basic --user tadm:tadm --connect-timeout 10"

# -----------------------------------------------------------------------------------------------------------------------------
# LOGGING TOOLS  [log_*]
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de logguer une chaine sur la console dans tous les cas (même s'il y a une redirection)
# @param $1 la chaine à logguer
log_console() {
  local ts=$(date '+%G%m%d%H%M%S')
  echo "CONSOLE|$ts|$1" > /dev/tty
}

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de logguer une chaine en niveau DEBUG
# @param $1 la chaine à logguer
log_debug() {
  if [ $LOGLEVEL -le $LOGLEVEL_DEBUG ]; then
    local ts=$(date '+%G%m%d%H%M%S')
    echo "DEBUG|$ts|$1"
  fi
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de logguer une chaine en niveau INFO
# @param $1 la chaine à logguer
log_info() {
  if [ $LOGLEVEL -le $LOGLEVEL_INFO ]; then
    local ts=$(date '+%G%m%d%H%M%S')
    echo " INFO|$ts|$1"
  fi
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de logguer une chaine en niveau WARN
# @param $1 la chaine à logguer
log_warn() {
  if [ $LOGLEVEL -le $LOGLEVEL_WARN ]; then
    local ts=$(date '+%G%m%d%H%M%S')
    echo " WARN|$ts|$1"
  fi
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de logguer une chaine en niveau ERROR
# @param $1 la chaine à logguer
log_error() {
  if [ $LOGLEVEL -le $LOGLEVEL_ERROR ]; then
    local ts=$(date '+%G%m%d%H%M%S')
    echo "ERROR|$ts|$1"
  fi
}

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction de trace sur STDOUT nous permet d'avoir l'heure d'execution
# @param $1 = texte à afficher
log() {
  if [ -z $1 ]; then
    echo ""
  else
    local ts=$(date '+%G%m%d%H%M%S')
    echo "$ts|$1"
  fi
}

# -----------------------------------------------------------------------------------------------------------------------------
# OTHER TOOLS [tools_*]
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction vérifie que le script s'exécution avec l'utilisateur root
tools_checkIsRootUser() {
  if [ ${EUID} -ne 0 ]; then
    echo "[ERROR] This script must be run as root" 1>&2
    exit 1
  fi
}

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de faire une attente et d'afficher la progression si $2==true
# @param $1 le compteur en secondes
# @param $2 true/false effectuer un affichage avec des points ?
tools_timer() {
  if [ "$2" = "true" ]; then
    for iter in `seq 1 $1`
    do
      printf "."
      sleep 1
    done
    # le 1er echo fait le retour à la ligne, le 2eme nous fait une ligne vide
    echo ""
    echo ""
  else
    sleep $1
  fi
  return 0
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction effectue un log sur la sortie standard du code retour puis fait la commande "exit"
# @param $1 le code retour
tools_exitWithCode() {
  echo ""
  echo "--------------- CODE RETOUR=$1 ---------------"
  echo ""
  exit $1
}

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction supprime tous les fichiers d'un répertoire sauf ceux indiqués
# @param $1 = chemin du dossier où effectuer la suppression
# @param $2 = nom des fichiers à exclure
# TODO A VALIDER
# TODO si plsuieurs : find $1/* ! -name modules.xml ! -name test.txt -type f
tools_deleteExclude() {
  if [ $# -ne 2 ]; then
		log_error "ECHEC tools_deleteExclude : il faut au moins 2 arguments"
		return 1
	fi
  find $1/* ! -name $2 -type f -exec rm -f {} \;
}

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet de supprimer tous les fichiers d'un certain type dans un dossier
# @param $1 = dossier racine
# @param $2 = extension (txt, js, css, ...)
# @param $3 = exit error code [optionnel] sinon return 1 en cas d'erreur
tools_deleteFilesOfType() {
	if [ $# -ne 2 ]; then
		log_error "ECHEC tools_deleteFilesOfType : il faut au moins 2 arguments"
		return 1
	fi
	rm -f "$1/"*.$2
	if [ $? -ne 0 ]; then
		log_error "ECHEC de la suppression des fichiers '.$2' depuis $1"
		if [ -z "$3" ]; then
			return 1
		else
			exit $3
		fi
	else
	  log_info "Suppression OK des fichiers $1/*.$2"
	fi
	return 0
}

# -----------------------------------------------------------------------------------------------------------------------------
# SERVICES TOOLS  [service_*]
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet d'arrêter et de désactiver un service
# @param $1 = nom du service. Exemple tomcat
# @param $2 = nom de l'instance.
service_disableInstance() {
  sudo /usr/bin/systemctl stop $1@$2
  sudo /usr/bin/systemctl disable $1@$2
}

# -----------------------------------------------------------------------------------------------------------------------------
# TOMCAT TOOLS  [tomcat_*]
# -----------------------------------------------------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet d'appeler en REST le manager tomcat pour effectuer différentes oéprations
# @param $1 = URL du serveur tomcat (ex: http://localhost:8080)
# @param $2 = methode http. Ex: GET, POST, PUT
# @param $3 = commande tomcat. Ex: list, undeploy?path=/xxx, deploy?path=/xxx
# @return 0 : OK, 1 : erreur HTTP, 2 : erreur Tomcat
tomcat_manager() {
  local response
  local urlTomcat="$1/manager/text/$3"
  log_info "[INSTALL]      Appel de ${urlTomcat} en $2 ..."
  response=$(curl --request $2 ${TOMCAT_CURL_PARAMS} ${urlTomcat})
  if [ $? -ne 0 ]; then
    log_info "[INSTALL]      ECHEC de l'appel $2 pour $3 : ${response}"
    return 1
  else
    log_debug "[INSTALL]      REPONSE TOMCAT : ${response}"
      # Il faut maintenant regarder la réponse, si elle commence par OK c'est bon sinon (FAIL) KO
    if [[ ${response} == OK* ]]; then
      log_info "[INSTALL]      HTTP $2 pour $3 OK"
      return 0
    else
      error "[INSTALL]      ECHEC de l'appel $2 pour $3"
      return 2
    fi
  fi
}
# -----------------------------------------------------------------------------------------------------------------------------
# Cette fonction permet d'appeler en REST le manager de l'instance tomcat locale pour effectuer différentes oéprations
# @param $1 = methode http. Ex: GET, POST, PUT
# @param $2 = commande tomcat. Ex: list, undeploy?path=/xxx, deploy?path=/xxx
# @return 0 : OK, 1 : erreur HTTP, 2 : erreur Tomcat
tomcat_localManager() {
  tomcatManager "http://localhost:8080" $1 $2
  return $?
}
