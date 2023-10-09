# Cheat-Sheet : Shell Syntax

## _shebang_ header

```shell
#!/bin/sh
```

```shell
#!/bin/bash
```

## Variables

```shell
if [ -z $variable ]; then
  echo "Variable vide"
fi

if [ -n $variable ]; then
  echo "Variable non vide"
fi
```

## if

:warning: Les espaces à l'intérieur des crochets sont **très importants**.

Syntaxe 1 :

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
if [ condition ]; then

fi
# avec ou sans espace ....
if [ condition ] ; then

fi
```

Condition multiple : 

```shell
if [ condition1 ] && [ condition2 ]; then
  echo "condition1 ET condition2 vérifiée"
fi
```

```shell
if [ condition1 ] || [ condition2 ]; then
  echo "condition1 OU condition2 vérifiée"
fi
```

Inverser : 

```shell
if [ ! condition ]; then
  echo "condition non vérifiée"
fi
```

```shell
if ! command
then
  echo "echec command"
fi
```

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
  PVL | GPVL) INPUT_="PVL" ;;
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
