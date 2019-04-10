# AsciiDoc Tools

## Links

### asciidoctor.org

* <https://asciidoctor.org/>
* [Writers Guite](https://asciidoctor.org/docs/asciidoc-writers-guide/)
* [Recommended Practices](https://asciidoctor.org/docs/asciidoc-recommended-practices/)
* :fr: [Débuter avec Asciidoctor](https://asciidoctor.org/news/2016/04/05/debuter-avec-asciidoctor/)
* [Syntax Quick Reference](https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/)
* [Asciidoc & Markdown Comparison](https://asciidoctor.org/docs/user-manual/#comparison-by-example)

### Others

* [Browser Extension](https://github.com/asciidoctor/asciidoctor-browser-extension)
* [Awesome Asciidoctor "tips"](http://mrhaki.blogspot.com/2017/10/awesome-asciidoctor-prevent.html)
* [User Guide](http://www.methods.co.nz/asciidoc/userguide.html)
* [DocGist](http://gist.asciidoctor.org/)
* [AsciidocFX](https://github.com/asciidocfx/AsciidocFX)
* [Asciidoc Live](https://asciidoclive.com/edit/scratch/1)
* [Font Awesome to PNG](http://fa2png.io/r/font-awesome/)
* [AsciiDoc cheatsheet](https://powerman.name/doc/asciidoc)
* [Using AsciiDoc and Asciidoctor to write documentation - Tutorial](http://www.vogella.com/tutorials/AsciiDoc/article.html)

## Sections

* `= Document Title (Level 0)`
* `== Level 1 Section Title`
* `=== Level 2 Section Title`
* `==== Level 3 Section Title`
* `===== Level 4 Section Title`
* `====== Level 5 Section Title`

:information_source: Add `[#primitives-nulls]` before for explicit id

:information_source: Use `<<section title>>` to link to a specific section

:information_source: Use `[[some_label]]` to define a section  `<<some_label>>` to link to that section

## Formatting

* `*bold*`
* `_italics_`
* `^supertext^` (without space)
* `~subtext~` (without space)
* `#overline text#`
* `[color]#overline red text#`
* Lien : `https://asciidocfx.com/[AsciidocFX]`
* HR : A line of three or more apostrophe characters will generate a ruler line. It generates a ruler (hr) tag for HTML : `'''`

* Horizontal rule : `'''`
* Page break : `<<<`

## Lists

:information_source: To force the start of a new list, offset the two lists by an empty line comment.

## Blocks

### Notes, Tips, ...

NOTE, TIP, IMPORTANT, WARNING, CAUTION

```adoc
NOTE: Text
```

```adoc
[NOTE]
.Title
--
Text
--
```

```adoc
[TIP]
.Title
--
Text
--
```

### Captions

```adoc
[caption="Example 1: "]
.An example with a custom caption
=====================================================================
Qui in magna commodo, est labitur dolorum an. Est ne magna primis
adolescens.
=====================================================================
```

### Quotes

```adoc
[quote, Ben Parker, Spiderman Movie]
____
With great power comes great responsibility.
____
```

```adoc
[quote,'http://en.wikipedia.org/wiki/Samuel_Johnson[Samuel Johnson]']
_____________________________________________________________________
Sir, a woman's preaching is like a dog's walking on his hind legs. It
is not done well; but you are surprised to find it done at all.
_____________________________________________________________________
```

### Q&A

```adoc
[qanda]
What is Asciidoctor?::
  An implementation of the AsciiDoc processor in Ruby.
What is the answer to the Ultimate Question?:: 42
```

## Tables

* [Changing Table and Column Width](http://mrhaki.blogspot.com/2014/11/awesome-asciidoctor-changing-table-and.html)
* [Table Column and Cell Alignment](http://mrhaki.blogspot.com/2014/11/awesome-asciidoctor-table-column-and.html)

```adoc
[cols="^1,12",options="header"]
|===
|Repère|Commentaire
a|icon:thumbs-up[2x green]
a|TODO
|===
```

* `cols="10%,20%,70%"` 3 colonnes de respectivement 10, 20 et 70% de large
* `cols="1,12"` Colonne 2 12 fois plus grande que colonne 1
* `^1` 1ère colonne alignée au centre
* `a|xxx` indique que le format de la colonne est Asciidoc, sinon il n'interprête pas l'intérieur comme du asciidoc
* `^.^` colonne alignée au centre et au milieu

## Colors

:information_source: <https://en.wikipedia.org/wiki/Web_colors#HTML_color_names>

Exemples :

* `[navy]*Maintenabilité*`
* `icon:thumbs-down[2x red]`

## Symbols

* [special-characters-and-symbols](https://docs.antora.org/antora/1.0/asciidoc/special-characters-and-symbols/)
* PI `{amp}#960;`

## Inline Icons

Quelques exemples :

* `icon:bolt[]` (foudre)
* `icon:heart[]`
* `icon:tags[]`
* `icon:shield[]`
* `icon:comment[]`
* `icon:file[]`
* `icon:battery-full[]`
* `icon:cog[] icon:cogs[]` (roue(s) crantée)
* `icon:thumbs-up[]`
* `icon:thumbs-down[]`
* `icon:exclamation-circle[]`
* `icon:warning[]`
* `icon:info[]`
* `icon:bell[]`
* `icon:check[]`
* `icon:check-circle[]`
* `icon:check-square[]`
* `icon:bullhorn[]` (megaphone)
* `icon:bug[]`
* `icon:ban[]`
* `icon:eye[]`
* `icon:leaf[]` (spring)
* `icon:tint[]` (goutte)
* `icon:linux[]`
* `icon:github-square[]`
* `icon:toggle-on[] icon:toggle-off[]`

:information_source: <https://fontawesome.com/icons>
