#import "../src/book.typ": *
#import "@preview/subpar:0.1.1"
#import "./manual-template.typ": *

#let manual-boxeq(body) = {
  set align(center)
  context{
    box(
      stroke: 1pt + default-config-colors.boxeq.darken(35%),
      radius: 5pt,
      inset: 0.6em,
      fill: default-config-colors.boxeq,
    )[#body]
  }
}

#show: manual-template.with(
	abstract : [Ce package Typst est une proposition de modèle pour la rédaction de mémoire thèse ou de HDR ou d'ouvrages scientifiques.],
	version: "Template 0.5.0",
	typst-version: "Typst 0.12"
)

= Qu'est-ce que Typst ?

#typst est un nouveau langage de balise open source é crit en Rust et développé à partir de 2019 par deux étudiants allemands, Laurenz Mädje et Martin Haug, dans le cadre de leur projet de master @Mad22 @Hau22. La version 0.1.0 a été publiée sur GitHub le 04 avril 2023#footnote[Adresse du dépôt GitHub : #link("https://github.com/typst/typst", text("https://github.com/typst/typst", fill: typst-color))].

#typst se présente comme un successeur de #LaTeX plus moderne, rapide et simple d'utilisation. Parmi ses avantages, on peut citer :

- la compilation incrémentale ;
- des messages d'erreur clair et compréhensible ;
- un langage de programmation Turing-complet ;
- une système de style cohérent permettant de configurer aisément tous les aspects de son document (police, pagination, marges, #sym.dots) ;
- une communauté active et sympathique (serveur Discord pour le support, annonce de nouveaux paquets) ;
- un système de paquets simple d'utilisation (pour rechercher ou voir la liste des paquets, n'hésitez pas à visiter #link("https://typst.app/universe", text("Typst: Universe", fill: typst-color))) ;
- des extensions pour VS Code existent, comme `Typst LSP` ou `Tinymist`, pour avoir des fonctionnalités similaires à `LaTeX Workshop`.

#v(0.5em)

Concernant la courbe d'apprentissage, la documentation de #typst est suffisamment bien écrite et détaillée pour permettre de créer rapidement ses propres documents. Il faut compter moins d'une heure pour prendre en main la syntaxe (sans mentir #emoji.face.beam). Pour accéder à la documentation, suivez ce #link("https://typst.app/docs", text("lien", fill: typst-color)). Pour faciliter la transition de #LaTeX vers #typst, un guide est disponible #link("https://typst.app/docs/guides/guide-for-latex-users/", text("ici", fill: typst-color)).

#typst peut être utilisé comme #LaTeX de deux manières différentes :

+ En ligne, via l'application web #link("https://typst.app", text("Typst", fill: typst-color)). Il suffit de créer un compte pour commencer à rédiger ses documents. L'application web fonctionne de façon similaire à Overleaf. L'offre gratuite est généreuse et permet de :
   - Créer et éditer des projets ;
	 - Partager et collaborer sur des projets ;
	 - Convertir des fichiers #LaTeX ou Word ;
	 - 200 Mb de stockage et jusqu'à 100 fichiers par projet.

+ En local, en installant le compilateur #typst. Pour cela, il faut suivre les instructions contenues dans le fichier README.md du dépôt #link("https://github.com/typst/typst", text("Github", fill: typst-color)) officiel. Une fois le compilateur installé, il est possible de compiler ses fichiers en utilisant la commande `typst compile` (compilation unitaire) ou `typst watch` (compilation incrémentale) dans le terminal.

  Une solution complémentaire consiste à utiliser un éditeur de texte comme VS Code avec l'extension `Tinymist` pour bénéficier de la coloration syntaxique, de l'autocomplétion et de la prévisualisation (munie d'une fonctionnalité similaire à `synctex` en #LaTeX) et export au format PDF.

= Installation du modèle

La collection de gabarits Cnam est disponible sur le dépôt #link("https://github.com/maucejo/book_template", text("Github", fill: typst-color)) de l'auteur. Vous pouvez ainsi soit cloner le dépôt, soit télécharger le fichier zip de la dernière _Release_ contenant les gabarits. Pour utiliser les gabarits, deux possibilités s'offrent à vous :

+ Copier l'ensemble du dossier `cnam_templates` dans le dossier de votre projet #typst. Vous pouvez alors inclure les gabarits dans votre document en utilisant par exemple la commande :
	#codesnippet[
	```typ
	#import "./src/book.typ": *
	```
	]

	#ibox[
		#set text(size: 11pt)
		L'adresse du fichier à utiliser dans votre fichier principal `nom_de_mon_document.typ` dépend de l'emplacement du dossier `book_template` dans votre projet.

		Il faut toutefois noter que le dossier contenant les gabarits doit être situé dans le même répertoire que votre fichier principal.
	]

+ Installer localement le dossier `book_template` dans un dossier accessible par le compilateur #typst. Pour cela, il suffit de suivre les instructions de la documentation officielle #link("https://github.com/typst/packages", text("ici", fill: typst-color)). Pour cela, il faut cependant que le nom du dossier corresponde au numéro de version du paquet et que celui-ci soit contenu dans le dossier `book_template` (actuellement `book/0.5.0`).

	#codesnippet[
		```typ
		// Si installation dans le dossier `/typst/packages/local`
		#import "@local/book:0.5.0": *

		// Si installation dans le dossier /typst/packages/preview`
		#import "@preview/book:0.5.0": *
		```
	]

	Ce process peut être automatisé en utilisant le script `just` contenu dans le fichier `justfile`. Pour cela, il suffit de lancer dans un terminal ouvert dans le dossier `cnam-templates` contenant les gabarits. . Une fois `just` installé, il suffit de lancer la commande :

	#codesnippet[
		```bash
		# Pour installer les gabarits dans le dossier `/typst/packages/local`
		just install

		# Pour installer les gabarits dans le dossier `/typst/packages/preview`
		just install-preview
		```
	]

	#ibox[Pour installer `just`, il faut suivre les instructions figurant dans le fichier README.md du dépôt #link("https://github.com/casey/just", text("Github", fill: typst-color)) officiel.]

// = Illustrations

// Avant de décrire plus en détail les principaux éléments du modèle, voici quelques images illustrant le rendu du modèle.

// #subpar.grid(
// 	gap: 1em,
// 	figure(image("manual-images/page_garde.png", width: 60%), caption: [Page de garde]),
// 	figure(image("manual-images/back-cover.png", width: 60%), caption: [Quatrième de ouverture]),
// 	figure(image("manual-images/page-chapitre.png", width: 60%), caption: [Introduction d'un chapitre]),
// 	figure(image("manual-images/page-chapitre-section.png", width: 60%), caption: [Section d'un chapitre]),
// 	columns: (1fr, 1fr),
// 	caption: [Illustrations du rendu du modèle]
// )

// #figure(
//   grid(columns: 2, column-gutter: 0em, row-gutter: 1em,
//   subfigure(image("manual-images/page_garde.png", width: 60%), caption: [Page de garde]),
// 	subfigure(image("manual-images/back-cover.png", width: 60%), caption: [Quatrième de ouverture]),
// 	subfigure(image("manual-images/page-chapitre.png", width: 60%), caption: [Introduction d'un chapitre]),
// 	subfigure(image("manual-images/page-chapitre-section.png", width: 60%), caption: [Section d'un chapitre])
//   ),
//   caption: [Illustrations du rendu du modèle],
// )


= Utilisation

Pour utiliser le modèle, il faut l'importer dans votre fichier principal `typ` en utilisant la commande suivante.

#codesnippet[
	```typ
	#import "@preview/book:0.5.0": *
	```
]

#ibox[
	#set text(size: 11pt)

	Si vous décomposez votre document en différents fichiers, il faut insérer la commande précédente en préambule de chaque fichier.
]

== Initilisation du modèle

Après avoir importé le modèle, celui doit être initialisé en appliquant une règle d'affichage (`show` rule) avec la commande #cmd("book") en passant les options nécessaires avec l'instruction `with` dans votre fichier principal `typ` :

#codesnippet(
	```typ
	#show book.with(
	  ...
	)
	```
)

Le modèle #cmd("book") possède un certain nombre de paramètres permettant de personnaliser le document. Voici la liste des paramètres disponibles :

#command("book", ..args(
	title: "Titre du document",
  author: "Nom de l'auteur",
  type: "thesis",
  lang: "fr",
  logo: "image(\"resources/images/logo_cnam.png\")",
  body-font: "Lato",
  math-font: "Lete Sans Math",
  config-titre: (:),
  config-colors: (:),
	[body]))[
		#argument("title", default: "Titre du document", types: "string")[Titre du mémoire de thèse ou de HDR.]

		#argument("author", default: "Nom de l'auteur", types: "string")[Nom de l'auteur du mémoire.]

		#argument("type", default: "thesis", types: "string")[Type de document.

			Deux types de modèles sont actuellement disponibles :
			- `"thesis"` pour une thèse (doctorat ou HDR)
			- `"textbook"` pour un ouvrage scientifique
		]

		#argument("lang", default: "fr", types: "string")[Langue du document. En fonction de la valeur prise par ce paramètre, la localisation  du document sera adaptée.

		Outre le français, la seule langue prise en compte est l'anglais (`lang: "en"`).]

		#argument("logo", default: "image(" + "resources/images/logo_cnam.png" + ")", types: "content")[Chemin vers le logo de l'établissement de préparation du mémoire.
			#wbox[
				#set text(size: 11pt)

				Il faut que le template soit à la racine du répertoire pour que le chemin soit correctement interprété. Dans le cas contraire, une erreur de compilation sera générée.
			]
		]

		#argument("body-font", default: "Lato", types: "string")[Nom de la police de caractère du corps du texte.]

		#argument("math-font", default: "Lete Sans Math", types: "string")[Nom de la police de caractère des équations mathématiques.]

		#ibox[
			#set text(size: 11pt)

			Les polices de caractère doivent être préalablement installées sur votre système pour être utilisées dans le document.

			Pour vérifier la disponibilité de la police choisie, vous pouvez entrer la commande `typst font` dans un terminal.
		]

		#argument("config-titre", default: (:), types: "dict")[
			Dictionnaire permettant de personnaliser la page de titre du document.

			Les options disponibles diffèrent en fonction du `type` de document choisi :
			- Pour un document de `type: "thesis"` :
				- `type` : Type de document -- `"phd"` ou `"hdr"`

				- `school` : Nom de l'établissement de préparation de la thèse

				- `doctoral-school` : Nom de l'école doctorale de rattachement

				- `supervisor` : Nom du/des directeurs de thèse ou du garant de la HDR

				- `cosupervisor` : Nom du ou des co-encadrants de thèse

				- `laboratory` : Nom du laboratoire de recherche de rattachement

				- `defense-date` : Date de soutenance de la thèse

				- `discipline` : Discipline dans laquelle s'inscrit la thèse

				- `speciality` : Spécialité dans laquelle s'inscrit la thèse

				- `commity` : Liste des membres du jury de soutenance

				#ibox[
					Chaque membre du jury est défini par un dictionnaire, de type #dtype((:)), contenant les champs suivant :
					- `name` : Nom du membre du jury
					- `position` : Poste occupé (MCF, PU, #sym.dots)
					- `affiliation` : Établissement de rattachement
					- `role` : Rôle dans le jury (Rapporteur, Examinateur, #sym.dots)
				]

				#example-box[
				```typc
				commity: (
					(
						name: "Hari Seldon",
						position: "Professeur des Universités",
						affiliation: "Streeling university",
						role: "Rapporteur",
					),
					(
						name: "Ford Prefect",
						position: "Maître de conférences",
						affiliation: "Beltegeuse University",
						role: "Examinateur"
					),
				)
				```
				]

			- Pour un document de `type: "textbook"` :
				- `subtitle` : Sous-titre de l'ouvrage

				- `edition` : Numéro de l'édition

				- `school` : Nom de l'établissement de préparation de l'ouvrage

				- `collection` : Nom de la collection

				- `year` : Année de publication

				- `cover-image` : Image de couverture de l'ouvrage
		]

		#argument("config-colors", default: (:), types: "dict")[
			Dictionnaire permettant de personnaliser les couleurs du document.

			Les options disponibles sont les suivantes :

			- `primary` : Couleur principale

			- `secondary` : Couleur secondaire

			- `boxeq` : Couleur des encadrés d'équations

			- `header` : Couleur de l'en-tête du document
		]
	]


#v(1.5em)
== Contenu du document

Le contenu du document est à rédiger dans le fichier principal `typ` ou dans des fichiers annexes. Le modèle fournit une structure de base pour la rédaction d'un document.

D'une manière générale, la partie du fichier principal correspondant au contenu du document est structurée de la manière suivante :
#codesnippet[
	```typ
	#show: front-matter

	#include "front-content.typ"

	#show: main-matter

	#tableofcontents()

	#listoffigures()

	#listoftables()
```
]

#codesnippet[
	```typ
	#part("Corps du document")

	#include "chapitre.typ"

	#bibliography("bibliography.bib")

	#show: appendix

	#part("Annexes du document")

	#include "appendix.typ"

	#back-cover(...)
	```
]

Le contenu du mémoire est divisé en trois parties principales : `front-matter`, `main-matter` et `appendix`. Ces éléments s'accompagnent de fonctions complémentaires permettant de faciliter la rédaction du mémoire.

=== Environnements

Le modèle propose trois environnements pour structurer le contenu du mémoire :

1. *front-matter* : environnement pour le contenu préliminaire du mémoire (page de garde, résumé, remerciements, #sym.dots). En terme de pagination, les pages sont numérotées en chiffres romains et les chapitres ne sont pas numérotés. Pour activer cet environnement, il faut insérer dans le fichier principal `typ` à l'endroit souhaité la commande suivante :
	#codesnippet[
		```typ
		#show: front-matter
		```
	]

2. *main-matter* : environnement pour le contenu principal du mémoire (introduction, tables des matières chapitres, conclusion, bibliographie, #sym.dots). Les pages sont numérotées et les chapitres sont numérotés en chiffres arabes. Pour activer cet environnement, il faut insérer dans le fichier principal `typ` à l'endroit souhaité la commande suivante :
	#codesnippet[
		```typ
		#show: main-matter
		```
	]

3. *appendix* : environnement pour le contenu des annexes du mémoire. Les pages sont numérotées en chiffres romains et les chapitres sont numérotés en lettres. Pour activer cet environnement, il faut insérer dans le fichier principal `typ` à l'endroit souhaité la commande suivante :
	#codesnippet[
		```typ
		#show: appendix
		```
	]

=== Parties

Pour structurer le contenu du mémoire, il est possible de définir des parties à l'aide de la fonction #cmd("part"). Pour insérer une nouvelle partie, il faut insérer la commande suivante :
#command("part", "\"Titre de la partie\"")[]

#v(1em)
=== Chapitre

Les chapitres du mémoire sont définis par la fonction #cmd("chapter") qui dispose d'une certain nombre de paramètres permettant d'adapter le rendu du chapitre en fonction du contexte. Voici la liste des paramètres disponibles :

#command("chapitre", arg[title],
..args(
	abstract: none,
	toc: true,
	numbered: true,
	[body],
)
)[
	#argument("title", types: "string")[Titre du chapitre.]

	#argument("abstract", default: none, types: "content")[Résumé affiché sous le titre du chapitre.]

	#argument("toc", default: true, types: "boolean")[Indique si un mini table des matières doit être affichée au début du chapitre.]

	#argument("numbered", default: true, types: "boolean")[Indique si le chapitre doit être numéroté.]
]

#v(1em)

#example-box[
```typ
#chapitre(
  "Introduction",
  abstract: [Résumé du chapitre],
  toc: true,
  numbered: true
)[...]
```
]

=== Bibliographie

Pour insérer une bibliographie, il faut insérer dans le fichier principal `typ` la commande suivante :
#codesnippet[
	```typ
	#bibliography("your-biblio-file.yml/bib")
	```
]

#ibox[
#set text(size: 11pt)
Le modèle propose deux formats de bibliographie : YAML et BibTeX.

Pour le fichier YAML, celui-ci est interprété par le module `hayagriva`, dont la documentation est disponible #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md", text("ici", fill: typst-color.darken(10%))).
]

Pour citer une référence bibliographique dans le texte, il suffit d'utiliser la commande #cmd("cite", arg[key]) ou plus simplement #text(`@key`, fill: typst-color) (où `key` est la clé associée à la référence).

Pour plus d'informations sur la gestion des références bibliographiques, il faut se référer à la documentation de la fonction #cmd("bibliography") de #typst (accessible #link("https://typst.app/docs/reference/model/bibliography/", text("ici", fill: typst-color))).

=== Fonctions complémentaires

Cette section présente les fonctions complémentaires implémentées dans le modèle pour faciliter la rédaction du mémoire.

*Tables des matières*

  - #cmd-["tableofcontents"] : création la table des matières.

	- #cmd-["listoffigures"] : création la table des figures.

	- #cmd-["listoftables"] : création la table des tableaux.

*Figures*

D'une manière générale, les figures sont insérées dans le document à l'aide de la fonction #cmd("figure") de #typst. Cependant, #typst ne dispose pas actuellement de mécanismes permettant de gérer les sous-figures (numérotation et référencement). Pour pallier ce manque, le modèle intègre une fonction #cmd("subfigure") permettant de gérer les sous-figures de manière adaptée. Cette fonction encapsule la fonction #cmd("subpar.grid") du package `subpar`.

#example-box[
	```typ
	#subfigure(
		figure(image("image1.png"), caption: []),
		figure(image("image2.png"), caption: []), <b>,
		columns: (1fr, 1fr),
		caption: [Titre de la figure],
		label: <fig:subfig>,
	)
	```

	L'exemple précédent illustre le cas d'une figure composée de deux sous-figures. La première sous-figure est accompagnée d'une légende, tandis que la seconde possède un #dtype("label") mais pas de titre. La seconde sous-figure peut ainsi être référencée dans le texte à l'aide de la commande #text(`@b`, fill: typst-color.darken(15%)).
]

*Équations*

Pour encadrer une équation importante, la fonction #cmd("boxeq") doit être utilisée.

#example-box[
	#set math.equation(numbering: "(1)")
	#show math.equation: set text(font: "Lete Sans Math", fallback: false)

	```typ
	$
	#boxeq[$p(A|B) prop p(B|A) space p(A)$]
	$
	```

	#align(center)[#line(stroke: 1pt + typst-color, length: 95%)]

	$
	#manual-boxeq[$p(A|B) prop p(B|A) space p(A)$]
	$
]

#pagebreak()
Pour créer une équation sans numérotation, il faut utiliser la fonction #cmd("nonumeq").

#example-box[
	#show math.equation: set text(font: "Lete Sans Math")
	```typ
	#nonumeq[$integral_0^1 f(x) dif x = F(1) - F(0)$]
	```

	#align(center)[#line(stroke: 1pt + typst-color, length: 95%)]

	#nonumeq[$ integral_0^1 f(x) dif x = F(1) - F(0) $]
]

*Quatrième de couverture*

La quatrième de couverture de la thèse est générée automatiquement à partir de la fonction #cmd("back-cover"), qui affiche les informations relatives à la thèse (titre et  auteur), ainsi qu'un résumé en français et en anglais.

#command("back-cover", ..args(
resume: none,
abstract: none
))[
	#argument("resume", types: "content")[Résumé de la thèse en français.]

	#argument("abstract", types: "content")[Résumé de la thèse en anglais.]
]

#v(1.5em)
= Paquets recommandés

Cette section présente une liste de paquets qui peuvent être pertinents lors de la rédaction d'un mémoire en #typst.

*Dessin* -- `CeTZ`
	- *Description* : Ce paquet se veut être un équivalent #typst de TiKZ pour #LaTeX.
	- *Liens* - #link("https://typst.app/universe/package/cetz", text("Typst: Universe", fill: typst-color)), #link("https://github.com/cetz-package/cetz", text("dépôt GitHub", fill: typst-color)) et #link("https://github.com/cetz-package/cetz/blob/stable/manual.pdf?raw=true", text("documentation", fill: typst-color)).

#v(0.5em)

*Boîtes* -- `showybox`
	- *Description* : Ce paquet permet de créer des boîtes de contenus (textes, #sym.dots) personnalisables.
	- *Liens* - #link("https://typst.app/universe/package/showybox", text("Typst: Universe", fill: typst-color)), #link("https://github.com/Pablo-Gonzalez-Calderon/showybox-package", text("dépôt GitHub", fill: typst-color)) et #link("https://github.com/Pablo-Gonzalez-Calderon/showybox-package/blob/main/Showybox's%20Manual.pdf", text("documentation", fill: typst-color)).

#v(0.5em)

*Code* -- `codelst`
	- *Description* : Ce paquet permet de formatter des blocs de code source en incluant notamment la numérotation des lignes.
	- *Liens* #link("https://typst.app/universe/package/codelst", text("Typst: Universe", fill: typst-color)), #link("https://github.com/jneug/typst-codelst", text("dépôt GitHub", fill: typst-color)) et #link("https://github.com/jneug/typst-codelst/blob/main/manual.pdf", text("documentation", fill: typst-color)).

#v(0.5em)

*Algorithme* -- `lovelace`
	- *Description* : Ce paquet permet d'écrire du pseudo-code, dont le formattage est personnalisable.
	- *Liens* - #link("https://typst.app/universe/package/lovelace", text("Typst: Universe", fill: typst-color)), #link("https://github.com/andreasKroepelin/lovelace", text("dépôt GitHub", fill: typst-color)) et documentation (voir ReadMe sur GitHub).

#v(0.5em)

*Mathématiques* - `physica`
	- *Description* : Ce paquet propose des raccourcis pour l'écriture de symboles mathématiques.
	- *Liens* - #link("https://typst.app/universe/package/physica", text("Typst: Universe", fill: typst-color)), #link("https://github.com/Leedehai/typst-physics", text("dépôt GitHub", fill: typst-color)) et #link("https://github.com/Leedehai/typst-physics/blob/v0.9.3/physica-manual.pdf", text("documentation", fill: typst-color)).

#v(0.5em)

*Glossaire* - `glossarium`
	- *Description* : Ce paquet permet de créer un glossaire.
	- *Liens* - #link("https://typst.app/universe/package/glossarium", text("Typst: Universe", fill: typst-color)), #link("https://github.com/ENIB-Community/glossarium", text("dépôt GitHub", fill: typst-color)) et #link("https://github.com/ENIB-Community/glossarium/blob/master/docs/main.pdf", text("documentation", fill: typst-color)).

#v(0.5em)

*Index* - `in-dexter`
	- *Description* : Ce paquet permet de créer aisément un index.
	- *Liens* : #link("https://typst.app/universe/package/in-dexter", text("Typst: Universe", fill: typst-color)), #link("https://github.com/RolfBremer/in-dexter", text("dépôt GitHub", fill: typst-color)) et #link("https://github.com/RolfBremer/in-dexter/blob/main/sample-usage.pdf", text("documentation", fill: typst-color)).

= Feuille de route

Le modèle est en cours de développement. Voici la liste des fonctionnalités qui sont implémentées ou le seront dans une prochaine version.

*Couvertures*

- [x] Page de garde
- [x] Quatrième de couverture


*Environnements*

- [x] Création de l'environnement `front-matter`
- [x] Création de l'environnement `main-matter`
- [x] Création de l'environnement `appendix`
- [x] Création de l'environnement `part`

*Tables des matières*

- [x] Création de la table des matières -- #cmd-["tableofcontents"]
- [x] Création de la table des figures -- #cmd-["listoffigures"]
- [x] Création de la table des tableaux -- #cmd-["listoftables"]
- [x] Création d'une mini table des matières en début de chapitre grâce au paquet `minitoc` (voir #link("https://typst.app/universe/package/minitoc", text("lien", fill: typst-color)))
- [x] Personnalisation des entrées (apparence, lien hypertexte) en modifiant l'élément `outline.entry`
- [x] Localisation des différentes tables

*Figures et tableaux*

- [x] Personnalisation de l'apparence des légendes des figures et des tableaux en fonction du contexte (chapitre ou annexe)
- [x] Titres courts pour les tables des figures et des tableaux
- [x] Création de la fonction #cmd-["subfigure"] pour les sous-figures via le package `subpar`
- [x] Référencement automatique des sous-figures via la modification de la fonction Typst #cmd-["ref"]
- [x] Recréation des liens hypertextes pour les sous-figures pour la navigation dans le document via la fonction Typst #cmd-["link"]

*Équations*

- [x] Adaptation de la numérotation des équations en fonction du contexte (chapitre ou annexe)
- [x] Création d'une fonction pour encadrer les équations importante -- #cmd-["boxeq"]
- [x] Création d'une fonction définir des équations sans numérotation -- #cmd-["nonumeq"]
- [x] Utilisation du package `equate` pour numéroter des équations d'un système de type (1.1a)

*Bibliographie*

- [x] Vérification de la liste des références via `bibtex`
- [x] Idem pour `hayagriva` (voir #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md", text("documentation", fill: typst-color)))

#bibliography("manual-biblio.yml", style: "american-institute-of-aeronautics-and-astronautics")

