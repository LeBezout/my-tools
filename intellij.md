# Configuration IntelliJ IDEA

:notebook: [IntelliJ IDEA Reference Card _by JetBrains_](https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf)

## Config personnelle

* Appearence & Behavior
  * Small labels in editor tabs
* Editor > General > Editor Tabs
  * Mark modified tabs with asterik
  * Tab Limit 20 au lieu de 10
* Editor > Code Style
  * Hard Wrap at : 180 au lieu de 120
* Editor > Code Style > Java > Import
  * Class count to use import with * : 25 au lieu de 5 (pour retarder l'utilisation de ce type d'import)
* Editor > Inspections
  * Décocher Spelling > Typo
* Empêcher l'ouverture automatique des fichiers des la sélection
  * Décocher "_Autoscroll to Source_" via la roue crantée de la vue _project_
* Editor > Spelling
  * Ajouter le [dictionnaire français](http://www.winedt.org/dict/fr.zip)
* Build, Execution, Deployment > Compiler > Annotation Processors
  * Enable annotation processing (pour Lombok par exemple)

## Plugins

* [Maven Helper Plugin](https://plugins.jetbrains.com/plugin/7179-maven-helper)
* [Snyk Vulnerabilities Scanning](https://plugins.jetbrains.com/plugin/10972-snyk-vulnerability-scanning)
* [SonarLint](https://plugins.jetbrains.com/plugin/7973-sonarlint)
* [Lombok](https://plugins.jetbrains.com/plugin/6317-lombok)
* [AsciiDoc](https://plugins.jetbrains.com/plugin/7391-asciidoc)
* [Bash Support](https://plugins.jetbrains.com/plugin/4230-bashsupport)

## Junit 5

Ajouter `junit-platform-launcher` correspondant à la version de Junit 5 utilisée :

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

## Correspondance Eclipse

| Fonction | Raccourci Eclipse | Raccourci IntelliJ |
| -------- | ----------------- | ------------------ |
| Générer `System.out.println` | syso | sout | 
| Structure | CTRL+O | CTRL+F12 |
| Accès à une classe | CTRL+SHIFT+T | CTRL+N |
| Accès à un fichier | CTRL+SHIFT+R | CTRL+SHIFT+N |
| Organiser les imports | CTRL+SHIFT+O | CTRL+ALT+O |
| Renommer | ALT+SHIFT+R | SHIFT+F6 |
