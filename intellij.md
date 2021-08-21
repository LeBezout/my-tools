# Configuration IntelliJ IDEA

:notebook: [IntelliJ IDEA Reference Card _by JetBrains_](https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf)

## Config personnelle

* Appearence & Behavior > Appearence
  * Small labels in editor tabs
* Appearence & Behavior > System Settings > HTTP proxy
  * Cocher Auto-detect proxy settings
* Editor > General
  * _Other_ : Cocher "_Show quick documentation on mouse move_"
* Editor > General > Auto Imports
  * Cocher Java > _Optimize imports on the fly_
* Editor > General > Editor Tabs
  * _Mark modified tabs with asterik_
  * _Tab Limit_ 20 au lieu de 10
* Editor > Code Style
  * Hard Wrap at : 180 au lieu de 120
* Editor > Code Style > Java
  * Onglet _Import_ : _Class count to use import with *_ : 250 au lieu de 5 (pour empêcher l'utilisation de ce type d'import)
  * Onglet _Import_ : _Names count to use static import with *_ : 200 au lieu de 3 (pour empêcher l'utilisation de ce type d'import)
  * Onglet _Wrapping and Braces_ section _Keep when reformatting_ : décocher _uncheck Line breaks_
* Editor > File Encodings
  * _Properties Files_ : sélectionner _ISO-8859-1_
* Editor > Inspections
  * Cocher Java > _Serialization issues_ → Serializable
* Editor > Spelling
  * ~~Ajouter le [dictionnaire français](http://www.winedt.org/dict/fr.zip)~~
  * Meilleure alternative : utiliser le plugin [Grazie](https://plugins.jetbrains.com/plugin/12175-grazie/)
* Build, Execution, Deployment > Compiler > Annotation Processors
  * Cocher _Enable annotation processing_ (pour Lombok par exemple)
* Roue crantée de la vue _project_
  * Décocher "_Autoscroll to Source_" (Empêcher l'ouverture automatique des fichiers dès la sélection)
  * Cocher "_Autoscoll from source_" (activer le suivi dans la vu explorateur)

:link: [Share settings through a settings repository](https://www.jetbrains.com/help/idea/sharing-your-ide-settings.html#settings-repository)

## Config outils

### Configurer le SDK	

* À chaque projet : File > Project Structure > Project Settings > Project > Project SDK.
* Pour tous les projets : File > Other settings > Structure for New Projects > Project Settings > Project > Project SDK.

### Configurer Maven	

* File > Settings > Build, Execution, Deployment > Build Tools > Maven.
* À chaque projet : File > Project Settings > Build, Execution, Deployment > Build Tools > Maven.
* Pour tous les projets : File > Other settings > Settings for New Projects > Build, Execution, Deployment > Build Tools > Maven.

## Plugins

* [Maven Helper Plugin](https://plugins.jetbrains.com/plugin/7179-maven-helper)
* [Snyk Vulnerabilities Scanning](https://plugins.jetbrains.com/plugin/10972-snyk-vulnerability-scanning)
* [SonarLint](https://plugins.jetbrains.com/plugin/7973-sonarlint)
* ~~[Lombok](https://plugins.jetbrains.com/plugin/6317-lombok)~~ inclu  désormais
* [AsciiDoc](https://plugins.jetbrains.com/plugin/7391-asciidoc)
* ~~[Bash Support](https://plugins.jetbrains.com/plugin/4230-bashsupport)~~
* [Key Promote X](https://plugins.jetbrains.com/plugin/9792-key-promoter-x/)
* ~~[Grazie](https://plugins.jetbrains.com/plugin/12175-grazie/)~~ inclu désormais
* [GitToolBox](https://plugins.jetbrains.com/plugin/7499-gittoolbox)
* [Rainbow Brackets](https://plugins.jetbrains.com/plugin/10080-rainbow-brackets)
* [JPA Buddy](https://plugins.jetbrains.com/plugin/15075-jpa-buddy)

## Junit 5

Ajouter `junit-platform-launcher` correspondant à la version de JUnit 5 utilisée :

```xml
<!-- Junit5 -->
<dependency>
  <groupId>org.junit.jupiter</groupId>
  <artifactId>junit-jupiter-api</artifactId>
  <version>5.4.2</version>
  <scope>test</scope>
</dependency>
<dependency>
  <groupId>org.junit.platform</groupId>
  <artifactId>junit-platform-launcher</artifactId>
  <version>1.4.2</version>
  <scope>test</scope>
</dependency>
```

:bulb: ou vérifier que la connexion réseau (proxy, ..) est OK pour que l'IDE puisse télécharger le nécessaire (jar, ...).

## Correspondance Eclipse

| Fonction | Raccourci Eclipse | Raccourci IntelliJ |
| -------- | ----------------- | ------------------ |
| Générer `System.out.println` | syso | sout | 
| Structure | CTRL+O | CTRL+F12 |
| Accès à une classe | CTRL+SHIFT+T | CTRL+N |
| Accès à un fichier | CTRL+SHIFT+R | CTRL+SHIFT+N |
| Organiser les imports | CTRL+SHIFT+O | CTRL+ALT+O |
| Renommer | ALT+SHIFT+R | SHIFT+F6 |

## FAQ

### Running unit test: Could not find or load main class ${surefireArgLine} / Impossible de trouver la classe @{jacocoUTArgLine}

Décocher _argLine_ dans File > Settings > Build, Execution, Deployment > Build Tools > Maven > Running Tests

### Maven+Download Source: Caused by: java.rmi.ConnectException: Connection refused to host: 127.0.0.1;

Fixed 2021.1

Sinon _Build Tools > Maven > Importing > JDK for Importer_ => sélectionner le même que le projet
