#import "@preview/thesistemplate:0.2.0": *
#import "./manual-template.typ": *

#show: manual-template.with(
	abstract : [Ce package Typst est une proposition de modèle pour la rédaction de mémoire thèse ou de HDR pour les personnels du Laboratoire de Mécanique des Structures et des Systèmes Couplés du Conservatoire National des Arts et Métiers.],
	version: "Template 0.2.1",
	typst-version: "Typst 0.11.1"
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

Pour finir, la documentation de #typst est suffisamment bien écrite et détaillée pour permettre de créer rapidement ses propres documents. Il faut compter moins d'une heure pour prendre en main la syntaxe (sans mentir #emoji.face.beam). Pour accéder à la documentation, suivez ce #link("https://typst.app/docs", text("lien", fill: typst-color)). Pour faciliter la transition de #LaTeX vers #typst, un guide est disponible #link("https://typst.app/docs/guides/guide-for-latex-users/", text("ici", fill: typst-color)).

= Illustrations

Avant de décrire plus en détail les principaux éléments du modèle, voici quelques images illustrant le rendu du modèle.

#figure(
  grid(columns: 2, column-gutter: 0em, row-gutter: 1em,
  subfigure(image("manual-images/page_garde.png", width: 60%), caption: [Page de garde]),
	subfigure(image("manual-images/back-cover.png", width: 60%), caption: [Quatrième de ouverture]),
	subfigure(image("manual-images/page-chapitre.png", width: 60%), caption: [Introduction d'un chapitre]),
	subfigure(image("manual-images/page-chapitre-section.png", width: 60%), caption: [Section d'un chapitre])
  ),
  caption: [Illustrations du rendu du modèle],
)

#pagebreak()
= Utilisation

Pour utiliser le modèle, il faut l'importer dans votre fichier principal `typ` en utilisant la commande suivante.

#codesnippet[
	```typ
	#import "./template/thesistemplate.typ": *
	```
]

#ibox[
	#set text(size: 11pt)

	Si vous décomposez votre document en différents fichiers, il faut insérer la commande précédente en préambule de chaque fichier.
]

== Initilisation du modèle

Après avoir importé le modèle, celui doit être initialisé en appliquant une règle d'affichage (`show` rule) avec la commande #cmd("thesistemplate") en passant les options nécessaires avec l'instruction `with` dans votre fichier principal `typ` :

#codesnippet(
	```typ
	#show thesistemplate.with(
	  ...
	)
	```
)

Le modèle #cmd("thesistemplate") possède un certain nombre de paramètres permettant de personnaliser le document. Voici la liste des paramètres disponibles :

#command("thesistemplate", ..args(
	title: "Titre de la thèse",
  author: "Nom du candidat",
  type: "these",
  school: "Conservatoire National des Arts et Métiers",
  doctoral-school: "Sciences des Métiers de l'Ingénieur",
  supervisor: ("Nom du directeur de thèse",),
  cosupervisor: none,
  laboratory: "Nom du laboratoire",
  defense-date: "01 janvier 1970",
  discipline: "Mécanique, Génie Mécanique, Génie Civil",
  specialty: "Mécanique",
  commity: (),
  lang: "fr",
  logo: "images/logo_cnam.png",
  body-font: "Lato",
  math-font: "Lete Sans Math",
	[body]))[
		#argument("title", default: "Titre de la thèse", types: "string")[Titre du mémoire de thèse ou de HDR.]

		#argument("author", default: "Nom du candidat", types: "string")[Nom de l'auteur du mémoire.]

		#argument("type", default: "these", types: "string")[Type de document (these, hdr).

		Le type du document figurant sur la page de garde sera adapté à la valeur prise par ce paramètre.

		#h(1em) Si #arg("type"): \"these\", le document sera intitulé _Thèse de doctorat_.

		#h(1em) Si #arg("type"): \"hdr\", le document sera intitulé _Habilitation à Diriger des Recherches_.
		]

		#argument("school", default: "Conservatoire National des Arts et Métiers", types: "string")[Nom de l'établissement de préparation du mémoire.]

		#argument("doctoral-school", default: "Sciences des Métiers de l'Ingénieur", types: "string")[Nom de l'école doctorale de rattachement du candidat.]

		#argument("supervisor", default: ("Nom du directeur de thèse",), types: "array")[Nom du/des directeurs de thèse ou du garant de la HDR. Chaque élément de la liste est de type #dtype("string").]

		#argument("cosupervisor", default: none, types: "array")[Nom du ou des co-encadrants de thèse. Chaque élément de la liste est de type #dtype("string")]

		#argument("laboratory", default: "Nom du laboratoire", types: "string")[Nom du laboratoire de recherche de rattachement du candidat.]

		#argument("defense-date", default: "01 janvier 1970", types: "string")[Date de soutenance du mémoire.]

		#argument("discipline", default: "Mécanique, Génie Mécanique, Génie Civil", types: "string")[Discipline dans laquelle s'inscrit le mémoire.]

		#v(2em)
		#argument("specialty", default: "Mécanique", types: "string")[Spécialité dans laquelle s'inscrit mémoire.]

		#argument("commity", default: (), types: "array")[Liste des membres du jury de soutenance. Chaque membre du jury est défini par un dictionnaire, de type #dtype((:)), contenant les champs suivant :

			- `name` : Nom du membre du jury
			- `position` : Poste occupé (MCF, PU, #sym.dots)
			- `affiliation` : Établissement de rattachement
			- `role` : Rôle dans le jury (Rapporteur, Examinateur, #sym.dots)

			#example-box[
				```typ
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
	 ]

		#argument("lang", default: "fr", types: "string")[Langue du document. En fonction de la valeur prise par ce paramètre, la localisation  du document sera adaptée.

		Outre le français, la seule langue prise en compte est l'anglais (`lang: "en"`).]

		#argument("logo", default: "images/logo_cnam.png", types: "string")[Chemin vers le logo de l'établissement de préparation du mémoire.
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
	]

== Contenu du mémoire

Le contenu du mémoire est à rédiger dans le fichier principal `typ` ou dans des fichiers annexes. Le modèle fournit une structure de base pour la rédaction du mémoire.

D'une manière générale, la partie du fichier principal correspondant au contenu du mémoire est structurée de la manière suivante :
#codesnippet[
	```typ
	#show: front-matter


	#include "front-content.typ"


	#show: main-matter


	#tableofcontents()

	#listoffigures()

	#listoftables()


	#include "chapitre.typ"


	#bibliography("bibliography.bib")


	#show: appendix


	#include "appendix.typ"


	#back-cover(...)
	```
]

Le contenu du mémoire est divisé en trois parties principales : `front-matter`, `main-matter` et `appendix`. Ces éléments s'accompagnent de fonctions complémentaires permettant de faciliter la rédaction du mémoire.

#pagebreak()
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

#pagebreak()
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
	#boxeq[$p(A|B) prop p(B|A) space p(A)$]
	$
]

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

#pagebreak()
*Environnements*

- [x] Création de l'environnement `front-matter`
- [x] Création de l'environnement `main-matter`
- [x] Création de l'environnement `appendix`

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
- [x] Création de la fonction #cmd-["subfigure"] pour les sous-figures
- [x] Référencement automatique des sous-figures via la modification de la fonction Typst #cmd-["ref"]
- [x] Recréation des liens hypertextes pour les sous-figures pour la navigation dans le document via la fonction Typst #cmd-["link"]

*Équations*

- [x] Adaptation de la numérotation des équations en fonction du contexte (chapitre ou annexe)
- [x] Création d'une fonction pour encadrer les équations importante -- #cmd-["boxeq"]
- [x] Création d'une fonction définir des équations sans numérotation -- #cmd-["nonumeq"]
- [ ] Numérotation des équations d'un système de type (1.1a) -- _Discussions en cours sur le dépôt Github de Typst_

// *Liens*

// - [ ] Personnalisation plus poussée des liens hypertextes (couleur, style, #sym.dots) ?

*Bibliographie*

- [x] Vérification de la liste des références via `bibtex`
- [x] Idem pour `hayagriva` (voir #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md", text("documentation", fill: typst-color)))

#bibliography("manual-biblio.yml", style: "american-institute-of-aeronautics-and-astronautics")

