# Trucs et astuces Shell Linux / Unix

## Normes

## Separators

### Path & Classpath

* on all Unix-like operating systems (such as Linux and Mac OS X), the directory structure has a Unix syntax, with separate file paths separated by a colon (`:`)
* on Windows, the directory structure has a Windows syntax, and each file path must be separated by a semicolon (`;`)
* when the Classpath is defined in manifest files, where each file path must be separated by a space (` `), regardless of the operating system

### Entêtes

```shell
#!/bin/sh
```

```shell
#!/bin/bash
```

## Fichiers et dossiers

### Outillage sur chemin

* Nom d'un fichier depuis son chemin complet `basename /che/min/fic` => `fic`
* Chemin du dossier d'un fichier depuis son chemin complet `dirname /che/min/fic` => `/che/min`

### Droits

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|
| `-` | `x` | `w` | `wx` | `r` | `rx` | `rw` | `rwx` |

* `chmod +x fic` ou `chmod u+x fic` ou `chmod g+x fic` ou `chmod o+x fic`

## Afficher les informations utiles sur le script et l'environnement

```shell
# Nom du shell
PROG_NAME=$(basename "$0")
# Nom de la machine
HOST_NAME=$(hostname)
# Version courte
SHORT_HOST_NAME="$(hostname --short)"
# Informations du système (OS, host)
SYSTEM_INFO=$(uname --all)
# Utilisateur exécutant le script
USER=$(id -u -n)
# Version Java
JAVA_VERSION=$(java -version 2>&1 | grep 'java version' | tr -d \")

echo "       HOST_NAME=${HOST_NAME}"
echo "          SCRIPT=$0"
echo "     EXECUTE PAR=${USER}"
echo "   ENVIRONNEMENT=${SYSTEM_INFO}"
echo "  VERSION CENTOS=$(cat /etc/centos-release)"
echo "  VERSION REDHAT=$(cat /etc/redhat-release)"
```

## Saisie manuelle

```shell
read -p  "Message" nomvariable
echo "Saisie=${nomvariable}"
```

## Formatter des dates

Date au format AAAAMMJJ :

```shell
echo `date '+%C%y%m%d'`
```

Date au format AAAAMMJJ HH:mm:ss :

```shell
logdate=`date '+%C%y%m%d'-%H:%M:%S`
```

Calcul sur une date :

```shell
date_moins_7_jour=`date '+%C%y%m%d' -d "$ma_date-7 days"`
```

## Variables

### Affecter une valeur par défaut

```shell
# If variable not set or null, use default.
LIQUIBASE_COMMAND=${1:-status}
# If variable not set or null, set it to default.
LIQUIBASE_COMMAND=${1:=status}
```

### Variables spéciales

* `$?` représente le code retour de la commande précédente
* `$$` représente le PID du shell qui interprète le script
* `$!` représente le PID d'une commande exécutée en arrière plan
* `$-` représente ?
* `$_` représente ?

## Paramètres d'un script (...ou d'une fonction)

* `$#` nombre de paramètres reçus
* `$0` nom du script
* `$*` tous les paramètres (sous forme d'une seule chaîne)
* `$@` tous les paramètres (sous forme d'un tableau)
* `$1` 1er paramètre
* `$2` 2eme paramètre

:warning: Les variables `$*` et `$@` lorsqu'elles ne sont pas entourées par des guillemets sont équivalentes : _`$@` has each parameter as a separate quoted string, whereas `$*` has all parameters as a single string._

## Filename Expansion

* `extension="${filename##*.}"` extension du fichier
* `filename="${filename%.*}"` nom du fichier sans l'extension

```shell
~% FILE="example.tar.gz"
~% echo "${FILE%%.*}"
example
~% echo "${FILE%.*}"
example.tar
~% echo "${FILE#*.}"
tar.gz
~% echo "${FILE##*.}"
gz
```

:link: [Shell Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)

## Conditions

### Syntaxes

:warning: Les espaces à l'intérieur des crochets sont **très importants**.

Synatxe 1 :

```shell
if [ condition ]
then

fi
```

Syntaxe 2 :

```shell
if [ condition ]; then

fi
```

:information_source: en rajoutant un `;` on peut placer `then` sur la même ligne.

Syntaxe 3 :

```shell
if [[ condition ]]; then

fi
```

Avec elif et else :

```shell
if [ condition ]; then
  echo "Le premier test a été vérifié"
elif [ autre_condition ]; then
  echo "Le second test a été vérifié"
elif [ encore_autre_condition ]; then
  echo "Le troisième test a été vérifié"
else
  echo "Aucun des tests précédents n'a été vérifié"
fi
```

Avec et (`&&`) / ou (`||`) :

```shell
if [ condition1 ] && [ condition2 ]
```

```shell
if [[ ${CONTEXT_ROOT} == "" || ${LIV_DIR} == "" || ${WAR_URL} == "" ]]; then
  echo "[INSTALL]      ECHEC : Attendu 3 arguments <artifactId> <livraisonDir> <warUrl>"
  exit 10
fi

if [[ ($1 != "--help") && (${CONTEXT_ROOT} == "" || ${LIV_DIR} == "" || ${WAR_URL} == "") ]]; then
  echo "[INSTALL] ECHEC : Attendu 3 arguments <artifactId> <livraisonDir> <warUrl>"
  exit 10
fi
```

Avec et (`-a`) / ou (`-o`) :

```shell
if [ $foo -ge 3 -a $foo -lt 10 ]; then
  echo "foo >= 3 && foo < 10"
fi
```

### Inverser une condition

:information_source: En rajoutant un `!` devant :

```shell
if [ ! condition ]; then
  echo "condition non vérifiée"
fi
```

### Double-bracket syntax

:information_source: enhanced version of the single-bracket syntax

* an asterisk (“*”) will expand to literally anything
* word splitting is prevented, you could omit placing quotes around string variables
* not expanding filenames
* combining expressions (`[[ cond1 && cond2 || cond3 ]]`)
* allows regex pattern matching using the “=~”

### Double-parenthesis syntax

:information_source: for arithmetic (number-based) conditions.

```shell
if (( $num <= 5 )); then
  echo "num <= 5"
fi
```

### Conditions sur fichiers et dossiers

| Condition | Signification |
|-----------|---------------|
| `-e $nomfichier` | Vérifie si le fichier existe. |
| `-a $nomfichier` | Vérifie si le fichier existe (**obsolète**). |
| `-b $nomfichier` | Vérifie si le fichier _périphérique de type bloc_ existe. |
| `-c $nomfichier` | Vérifie si le fichier _périphérique de type caractères_ existe. |
| `-p $nomfichier` | Vérifie si le fichier _tube_ existe. |
| `-f $nomfichier` | Vérifie si le fichier est un fichier. Un vrai fichier cette fois, pas un dossier. |
| `-d $nomfichier` | Vérifie si le fichier est un répertoire. N'oubliez pas que sous Linux, tout est considéré comme un fichier, même un répertoire ! |
| `-r $nomfichier` | Vérifie si le fichier est lisible (r). |
| `-w $nomfichier` | Vérifie si le fichier est modifiable (w). |
| `-x $nomfichier` | Vérifie si le fichier est exécutable (x). |
| `-g $nomfichier` | Vérifie si le groupe est positionné sur le fichier. |
| `-L $nomfichier` | Vérifie si le fichier est un lien symbolique (raccourci). |
| `-h $nomfichier` | Vérifie si le fichier est un lien symbolique (raccourci). |
| `-s $nomfichier` | Vérifie si le fichier est n'est pas vide (taille > 0). |
| `-S $nomfichier` | Vérifie si le fichier est n'est pas vide (taille > 0). |
| `-O $nomfichier` | Vérifie si le fichier existe et est un socket. |
| `$fichier1 -nt $fichier2` | Vérifie si `fichier1` est plus récent que `fichier2` (**n**ewer**t**han). |
| `$fichier1 -ot $fichier2` | Vérifie si `fichier1` est plus vieux que `fichier2` (**o**lder**t**han). |
| `$fichier1 -ef $fichier2` | Vérifie si `fichier1` et `fichier2` référencent le même "device". |

:bulb: <https://abs.traduc.org/abs-fr/ch07s02.html>

```shell
# Test si un dossier n'est pas présent
if [ ! -d "${INPUT_ROOT_DIR}" ]; then
  echo "Dossier racine input ${INPUT_ROOT_DIR} introuvable"
  exit 1
fi
```

```shell
# Test si un fichier n'est pas présent
if [ ! -f "${INPUT_FILE}" ]; then
  echo "Fichier input ${INPUT_FILE} introuvable"
  exit 1
fi
```

### Codes retour

```shell
if [[ $? -ne 0 ]]; then
  echo "différent de 0"
fi
```

```shell
if [[ $? -eq 0 ]]; then
  echo "égal à 0"
fi
```

### Entiers

Egalité :

```shell
if [[ ${count} = 0 ]]; then
  echo "count vaut zero"
fi

if [[ ${var1} -eq ${var2} ]]; then
  echo "var1 == var2"
fi
```

Différence :

```shell
if [[ ${var1} -ne ${var2} ]]; then
  echo "var1 != var2"
fi
```

Inférieur :

```shell
if [[ ${var1} -lt ${var2} ]]; then
  echo "var1 < var2"
fi

if [[ ${var1} -le ${var2} ]]; then
  echo "var1 <= var2"
fi
```

Supérieur :

```shell
if [[ ${var1} -gt ${var2} ]]; then
  echo "var1 > var2"
fi
if [[ ${var1} -ge ${var2} ]]; then
  echo "var1 >= var2"
fi
```

### Chaînes

```shell
if [[ -z $variable ]]; then
  echo "Variable vide"
fi
```

```shell
if [[ -n $variable ]]; then
  echo "Variable non vide"
fi
```

```shell
if [[ $variable = "valeur" ]]; then
  echo "Variable vaut valeur"
fi
# mais aussi avec ==
if [[ $variable == "valeur" ]]; then
  echo "Variable vaut valeur"
fi
```

```shell
if [[ $variable != "valeur" ]]; then
  echo "Variable différent valeur"
fi
```

```shell
# double [[ ]] obligatoire ici (et le * en dehors des guillemets!)
if [[ $variable == "valeur"* ]]; then
  echo "Variable commence par valeur"
fi
```

## Autres structures et boucles

## for

```shell
for iter in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
  printf "."
  sleep 1
done

for variable in 'valeur1' 'valeur2' 'valeur3'
do
  echo "La variable vaut $variable"
done

for fichier in `ls`
do
  echo "Fichier trouvé : $fichier"
done

for fichier in /dir/*.txt
do
  echo "Fichier trouvé : $fichier"
done

for fichier in $(find /home/vagrant/.mozilla/firefox/* -name "prefs.js")
do
  echo "Fichier trouvé : $fichier"
done
```

:information_source: Le séparateur est espace.

## while

```shell
while [ condition ]; do
  echo 'Action en boucle'
done
```

## case

```shell
case $INPUT in
  GAN)  INPUT="GASS" ;;
  GASS) ;;
  GRA)  ;;
  GRAA) INPUT="GRA" ;;
  GGE)  ;;
  GOC)  ;;
  GOI)  ;;
  LBR)  ;;
  GLBR) INPUT="LBR" ;;
  PVL)  ;;
  GPVL) INPUT_="PVL" ;;
  ALL) echo "Valeur ALL non prise en charge actuellement"; exit 2;;
  *) echo "Code invalide"; exit 2;
esac
```

```shell
case $1 in
  "Bruno")
    echo "Salut Bruno !"
    ;;
  "Michel")
    echo "Bien le bonjour Michel"
    ;;
  *)
    echo "Default"
    ;;
esac
```

:warning: Le double point-virgule dit à bash d'arrêter ici la lecture du `case`. Il saute donc à la ligne qui suit le `esac`.

## HTTP

### Extraire le nom de fichier depuis son URL

```shell
driver_filename="${URL_JAR_JDBC##*/}"
```

### curl

:link: [Common Options](https://gist.github.com/subfuzion/08c5d85437d5d4f00e58)

Stocker la réponse dans une variable :

```shell
response=$(curl --request POST ${CURL_PARAMS} ${URL_WS_SOLARIS}/$1/$2)
```

Récupération du statut HTTP :

```shell
response=$(curl -sw '\n%{http_code}' ...) # -sw pour rajouter une ligne à la fin contenant le statut HTTP
http_status=$(printf "$response" | tail --lines=1) # tail pour récupérer la valeur
if [ $http_status -eq 200 ]; then
  # OK
else
  # KO
fi
```

:warning: ne pas faire dans le cas du téléchargement d'un fichier (utiliser `--fail`, voir ci-après)

Télécharger un fichier :

```shell
curl -L ${FLE_URL} -o ${OUTPUT_DIR}/file

# --fail pour verifier que ca se passe bien
if ! curl --fail --location "${FLE_URL}" --output "${OUTPUT_DIR}/file"
then
  exit 1
fi
```

ou pour conserver le nom d'origine :

```shell
curl --location https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz --remote-name
```

Poster des données :

```shell
curl --header "content-type: application/json" --data "{\"param\": \"value\"}"  http://localhost:8080
```

Référencer un fichier :

```shell
curl --header "content-type: text/xml" --data @folder/data.xml http://localhost:8080
```

Multipart Form :

```shell
curl -F "livraison={\"codeSa\":\"MONAPP\",\"packageAuto\":false,\"versionSa\":\"VERSION_SA\",\"patch\": \"PATCH\",\"codeProjet\":\"\",\"tagSources\":\"TAG_NAME\",\"codeFiliere\":\"OPN\"};type=application/json" -F "file=@%WORKSPACE_DEV%\app\app-livraison\target\livraison.zip" --user "%BUILD_USER_ID%:%PASSWORD%" https://app.entreprise/services/livraison?deliver=%LIVRER%
```

Common arguments :

* `-s, --silent` : don't output anything
* `-v, --verbose` : mode verbeux
* `-V, --version` : affichage de la version
* `--noproxy app.entreprise.fr` : turn-off proxy for this URL
* `--insecure` : turn-off SSL certificate verification
* `--user "USER_ID:PASSWORD"`
* `-w, --write-out` : output after completion

### wget

```shell
wget -nv -P ${OUTPUT_DIR} ${FLE_URL}
```

## Groupes et utilisateurs

### chown : changement de propriétaire

```shell
chown -R vagrant:vagrant $FOLDER
```

```shell
chown vagrant:vagrant $FILE
```

## Outils courants

### source

> source is a **bash specific** shell built-in command that executes the content of the file passed as argument, in the current shell. It has a synonym in . (period).

:warning: :

* Il vaut mieux utiliser `.` qui est le standard
* Le script va s'exécuter avec le même contexte que le script qui le lance (variables, fonctions, ...)
* Un `exit` dans le script appelé va entraîner l'arrêt du script appelant

### echo

:information_source: Interprétation des backslash : `echo -e "\n"`

:information_source: Afficher l'aide : `help echo`

:information_source: Ne pas faire de saut de ligne à la fin : `echo -n "str"`

### grep

Recherche textuelle dans des fichiers. Exemple : `grep -rnw '/path/to/somewhere/' -e 'pattern'`

`grep -rnw '/path/to/somewhere/' -e 'pattern'`

* `-q` or `--quiet` suppress all normal output,
* `-r` or `-R` is recursive,
* `-n` is line number, and
* `-w` stands for match the whole word.
* `-l` (lower-case L) can be added to just give the file name of matching files.

Along with these, `--exclude`, `--include`, `--exclude-dir` flags could be used for efficient searching:

* This will only search through those files which have .c or .h extensions: `grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"`
* This will exclude searching all the files ending with `.o` extension:`grep --exclude=*.o -rnw '/path/to/somewhere/' -e "pattern"`
* For directories it's possible to exclude a particular directory(ies) through `--exclude-dir` parameter. For example, this will exclude the dirs dir1/, dir2/ and all of them matching *.dst/: `grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e "pattern"`

Petite fonction utile :

```shell
search() {
	grep -rnw '.' -e "$1"
}
```

### tail / head

* `echo $data | tail --lines=<n>` avec `<n>` le nombre de lignes en partant de la fin
* `echo $data | head --lines=<n>` avec `<n>` le nombre de lignes en partant du début

ou `--bytes=<n>` avec `<n>` le nombre d'octets

:information_source: **head** : with the leading '-', print all but the last `<n>` bytes of each file

### find

TODO

### wc

:information_source: **Syntaxe :** `wc [OPTION]... [FILE]...`

```text
  -c, --bytes            print the byte counts
  -m, --chars            print the character counts
  -l, --lines            print the newline counts
      --files0-from=F    read input from the files specified by
                           NUL-terminated names in file F;
                           If F is - then read names from standard input
  -L, --max-line-length  print the length of the longest line
  -w, --words            print the word counts
```

### cut

:information_source: **Syntaxe :** `cut -d<sep> -f<nb>`

```shell
cut -d: -f1 /etc/passwd
java -version 2>&1 | grep 'java version' | tr -d \" | cut -d' ' -f3
```

### tr

TR permet de traduire (remplacer) ou supprimer des caractères.

:information_source: **Syntaxe :** `tr -options motif1 motif2`

```shell
# suppression des guillemets
java -version 2>&1 | tr -d \"
# suppression des sauts de ligne
commande1 | tr -d '\n' | commande2
# Remplacement de caractères
echo cuicui | tr ui ou
# Convertir toutes les MAJUSCULES en minuscules
echo COUCOU | tr [:upper:] [:lower:]
```

### eval

:link: [La commande eval](https://www.quennec.fr/trucs-astuces/syst%C3%A8mes/gnulinux/programmation-shell-sous-gnulinux/aspects-avanc%C3%A9s-de-la-programmation-shell/la-commande-eval)

```shell
GITLAB_USER_LOGIN=GS2250
token_GS2250=666

echo "user -> " ${GITLAB_USER_LOGIN}
token=$(eval "echo \${token_${GITLAB_USER_LOGIN}}")
echo "TOKEN=${token}"
```

### sed [Stream EDitor]

:link: [Stream_Editor](https://fr.wikipedia.org/wiki/Stream_Editor)

* The -i option causes the file to be edited "in place"
* `sed -i~` optional argument to create a backup file

```shell
# Token sous forme {{token}}
sed -i "s/{{montoken}}/${mavariable}/g" $FILE

# Token sous forme ${token}
sed -i "/${montoken}=/ s/=.*/=${mavariable}/" $FILE

# Regexp
sed -i "s/Exec=.*/Exec=\/usr\/share\/code\/code --unity-launch \/home\/vagrant\/git\/DOMINOS %F/g" /home/vagrant/Desktop/code.desktop

# Suppression des lignes vide d'un fichier
sed -i "/^$/d" ${file}
```

:link: <http://www.theunixschool.com/2014/08/sed-examples-remove-delete-chars-from-line-file.html>

#### deal with paths

> The best way to deal with paths in sed is to use a character other than / as the regexp delimeter --any will do, i.e.

```shell
sed s,a,b,

# is just the same as
sed s/a/b/
```

> Then you don't have to escape the slashes in the search/replace patterns.

#### Replace tokens examples

```shell
sed  -e "s#@@DLVR_COMPOSANT@@#${Composant}#g" \
     -e "s#@@DLVR_TIMESTAMP@@#${DateReq}#g" \
     -e "s#@@DLVR_PACKAGE_AUTHORNAME@@#${Auteur}#g" \
     -e "s#@@DLVR_PACKAGE_CREATIONDATE@@#${DateReq}#g" \
     -e "s#@@DLVR_PRODUCT_NAME@@#${IN_CODE_SA}#g" \
     -e "s#@@DLVR_PACKAGE_NAME@@#${Composant}.${DateReq}.tar.gz#g" \
     -e "s#@@APPFOLDEROWNERNAME@@#${UserPwc}#g" \
     -e "s#@@APPFOLDERGROUPNAME@@#${GrpPwc}#g" \
     -e "s#@@DLVR_APP_NAME@@#${IN_TRIGRAMME}#g" \
    ${BATCH_DIR}/LIV_Install_Model.txt >${InstallScript}
```

### awk (Aho-Weinberger-Kernighan)

:link: [awk](https://fr.wikipedia.org/wiki/Awk)

```shell
# TODO
```

## File systems

### df

```shell
output=$(df -h ${HANGAR_DIR})
usedspace=`echo "${output}" | tail -n +3 |  awk '{ print $4 }' | cut -d '%' -f1`
```

### du

```shell
# Taille d'un dossier sans afficher tous les sous-dossiers (-s)
du -h -s /sonatype-work/storage/g2s-binary/
```

## Pipes

```shell
# TODO
```

## Options et arguments

:link: Syntaxe `getopts` <https://wiki.bash-hackers.org/howto/getopts_tutorial>

:link: Syntaxe _GNU-Style_ TODO

## Couleurs

* <https://www.growingwiththeweb.com/2015/05/colours-in-gnome-terminal.html>

## Trucs et astuces

### Tableaux

```sh
#!/bin/sh

# Index de parcours des tableaux de noms et d'ID
GIT_REPO_INDEX="0 1 2"
# Noms des depots
GIT_REPO_NAMES[0]=REPO1
GIT_REPO_NAMES[1]=REPO2
GIT_REPO_NAMES[2]=REPO3
# Identifiants des depots pour l'API
GIT_REPO_IDS[0]=396
GIT_REPO_IDS[1]=433
GIT_REPO_IDS[2]=397

echo "GIT_REPO_INDEX=${GIT_REPO_INDEX[*]}"
echo "GIT_REPO_NAMES=${GIT_REPO_NAMES[*]}"
echo "GIT_REPO_IDS=${GIT_REPO_IDS[*]}"

for INDEX in ${GIT_REPO_INDEX}; do
  echo "${INDEX} | NAME ${GIT_REPO_NAMES[${INDEX}]} |  ID ${GIT_REPO_IDS[${INDEX}]}"
done
```

## Liens utiles

* <https://linuxacademy.com/blog/linux/conditions-in-bash-scripting-if-statements/>
* <https://openclassrooms.com/courses/reprenez-le-controle-a-l-aide-de-linux/introduction-aux-scripts-shell>

## Alternatives

* <https://blogs.igalia.com/dpino/2011/10/13/configuring-different-jdks-with-alternatives/>
* <https://www.if-not-true-then-false.com/2010/install-sun-oracle-java-jdk-jre-6-on-fedora-centos-red-hat-rhel/>
