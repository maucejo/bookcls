#import "@preview/mantys:1.0.2": *
#import "@preview/showybox:2.0.4": *
#import "@preview/swank-tex:0.1.0": LaTeX
#import "@preview/cheq:0.2.2": *
#import "../src/bookly.typ": *

#show: checklist.with(fill: eastern.lighten(95%), stroke: eastern, radius: .2em)

#let typst-color = rgb(35,157,173)
#let Typst = text("Typst", fill: typst-color)

#let abstract = [This Typst package is a proposed template for writing thesis dissertations, French habilitations, or scientific books.]

#show: mantys(
  name: "bookly.typ",
  version: "0.2.0",
  authors: ("Mathieu Aucejo"),
  license: "MIT",
  description: "Write beautiful scientific book or thesis with Typst",
  repository: "https://github.com/maucejo/bookly",

  title: "Book Template",
  date: datetime.today(),

  abstract: abstract,
  show-index: false,
)

= Usage

== Using `bookly`

To use the #package[bookly] template, you need to include the following line at the beginning of your `typ` file:
#codesnippet[```typ
#import "@preview/bookly:0.2.0": *
```
]

== Initializing the template

After importing #package[bookly], you have to initialize the template by a show rule with the #cmd[bookly] command. This function takes an optional argument to specify the title of the document.
#codesnippet[```typ
#show: bookly.with(
  ...
)
```
]

#command("bookly", ..args(
	title: "Title",
  author: "Author Name",
	theme: "fancy",
	layout: "standard",
	lang: "fr",
	fonts: "default-fonts",
	colors: "default-colors",
	title-page: none,
	[body]))[
		#argument("title", default: "Title", types: "string")[Title of the book or the thesis.]

		#argument("author", default: "Author Name", types: "string")[Author of the book.]

		#colbreak()

		#argument("theme", default: "fancy", types: "function")[Theme of the document. Possible values are:
			-  `fancy` (default)
			- `modern`
			- `classic`
			- `orly`
		]

		#argument("layout", default: "standard", types: "string")[Layout of the document. Possible values are:
			- `"standard"` (default)
			- `"tufte"`
		]

		#argument("lang", default: "fr", types: "string")[Language of the document.

		Supported languages French (`"fr"`-- default) and English (`"en"`)]

		#argument("fonts", default: "default-fonts", types: "dict")[Fonts used in the document. It contains the following keys:
			- `body` #dtype(str) -- Font used for the body text (default: `"New Computer Modern"`)
			- `math` #dtype(str) -- Font used for mathematical equations (default: `"New Computer Modern Math"`)
			- `raw` #dtype(str) -- Font used for raw text (default: `"DejaVu Sans Mono"`)
		]

		#argument("title-page", default: none, types: "content")[Content of the title page.]

		#argument("colors", default: "default-colors", types: "dict")[Colors used in the document. It contains the following keys:
			- `primary` #dtype(color) -- Primary color (default: `rgb("#c1002a")`)
			- `secondary` #dtype(color) -- Secondary color (default: `rgb("#dddddd").darken(15%)`)
			- `boxeq` #dtype(color) -- Color of equation boxes (default: `rgb("#dddddd")`)
			- `header` #dtype(color) -- Color used for adapting the color of the document headers (default: `black`)
		]
]

=== Initialization example
#codesnippet[
```typ
#show: bookly.with(
	author: "Author Name",
	fonts: (
		body: "Lato",
		math: "Lete Sans Math"
	),
	theme: modern,
	lang: "en",
	logo: image("path_to_image/image.png")
)
```
]

=== Themes gallery <sss:themes>

==== Fancy

#subfigure(
	columns: 2,
	figure(image("manual-images/part-fancy.png", width: 80%), caption: "Part"),
	figure(image("manual-images/chapter-fancy.png", width: 80%), caption: "Chapter"),
	figure(image("manual-images/chapter-nonum-fancy.png", width: 80%), caption: "Unnumbered chapter"),
	figure(image("manual-images/sections-fancy.png", width: 80%), caption: "Section"),
)

==== Modern

#subfigure(
	columns: 2,
	figure(image("manual-images/part-modern.png", width: 80%), caption: "Part"),
	figure(image("manual-images/chapter-modern.png", width: 80%), caption: "Chapter"),
	figure(image("manual-images/chapter-nonum-modern.png", width: 80%), caption: "Unnumbered chapter"),
	figure(image("manual-images/sections-modern.png", width: 80%), caption: "Section"),
)

==== Classic

#subfigure(
	columns: 2,
	figure(image("manual-images/part-classic.png", width: 80%), caption: "Part"),
	figure(image("manual-images/chapter-classic.png", width: 80%), caption: "Chapter"),
	figure(image("manual-images/chapter-nonum-classic.png", width: 80%), caption: "Unnumbered chapter"),
	figure(image("manual-images/sections-classic.png", width: 80%), caption: "Section"),
)

==== Orly

#subfigure(
	columns: 2,
	figure(image("manual-images/part-orly.png", width: 80%), caption: "Part"),
	figure(image("manual-images/chapter-orly.png", width: 80%), caption: "Chapter"),
	figure(image("manual-images/chapter-nonum-orly.png", width: 80%), caption: "Unnumbered chapter"),
	figure(image("manual-images/sections-orly.png", width: 80%), caption: "Section"),
)

=== Layout

The template currently supports two layouts: `standard` and `tufte`.

The `standard` layout is the default layout, with symmetric margins. It is the most common layout for books and theses. Some examples of the standard layout are presented in @sss:themes "Themes gallery".

The `tufte` layout is inspired by the works of Edward Tufte, which emphasizes simplicity and clarity, often using wide margins for notes and figures. It is particularly suitable for books or theses that require extensive annotations or side comments. To implement the `tufte` layout, the template comes with several helper functions, implementing side notes, side figures, full width blocks, etc. (see @ss:tufte for details). Some examples of the `tufte` layout are presented below.

#subfigure(
	columns: 3,
	figure(image("manual-images/tufte-figures.png"), caption: [Figures and side figures]),
	figure(image("manual-images/tufte-citations.png"), caption: [Citations]),
	figure(image("manual-images/tufte-wide.png"), caption: [Full width elements]),
)

= Book content

The content of the book should be written in the main `typ` file or in additional files. The template provides a basic structure for writing a book.

In general, the section of the main file corresponding to the book content is structured as follows:
#codesnippet[
	```typ
	#show: front-matter

	#include "front-content.typ"

	#show: main-matter

	#tableofcontents

	#listoffigures

	#listoftables

	#part("Main body")

	#include "chapter.typ"

	#bibliography("bibliography.bib")

	#show: appendix

	#part("Document appendices")

	#include "appendix.typ"
	```
]

The content of the thesis is divided into three main sections: `front-matter`, `main-matter`, and `appendix`. These elements are accompanied by additional functions to facilitate writing.

== Environments

The template provides three environments to structure the thesis content:

1. *front-matter*: environment for preliminary content (cover page, abstract, acknowledgments, etc.). Pages are numbered with Roman numerals and chapters are not numbered. To activate this environment, insert the following command in the main `typ` file at the desired location:
	#codesnippet[
		```typ
		#show: front-matter
		```
	]

2. *main-matter*: environment for the main content (introduction, tables of contents, chapters, conclusion, bibliography, etc.). Pages and chapters are numbered with Arabic numerals. To activate this environment, insert the following command in the main `typ` file at the desired location:
	#codesnippet[
	```typ
	#show: main-matter
	```
]

3. *appendix*: environment for the appendices. Pages are numbered with Roman numerals and chapters are numbered with letters. To activate this environment, insert the following command in the main `typ` file at the desired location:
	#codesnippet[
		```typ
		#show: appendix
		```
	]

== Parts and chapters

To structure the book content, you can define parts using the #cmd("part") function. To insert a new part, use the following command:
#codesnippet[
	```typ
	#part("Part title")
	```
]

Despite chapters can be defined using the standard #Typst markup language. This template defined a fonction #cmd("chapter") that allows to avoid boilerplate code, such as the manual inclusion of standard elements like title, abstract, and minitoc.

#command("chapter", arg[title],
..args(
	abstract: none,
	toc: true,
	numbered: true,
	[body],
)
)[
	#argument("title", types: "string")[Chapter title.]

	#argument("abstract", default: none, types: "content")[Summary displayed below the chapter title.]

	#argument("toc", default: true, types: "boolean")[Indicates whether a mini table of contents should be displayed at the beginning of the chapter.]

	#argument("numbered", default: true, types: "boolean")[Indicates whether the chapter should be numbered.]
]

#codesnippet[
```typ
	#chapter(
		"First chapter",
		abstract: lorem(20),
		)[
			// Content of the chapter
		]
```
]
#info-alert[If you use a #sym.ast\.typ file for each chapter, you can type at the top of the file the following code.

	#codesnippet[
		```typ
		#show: chapter.with("First chapter", abstract: lorem(20), toc: true)

		// Content of the chapter
		== First section
		```
	]
]

For unnumbered chapters, you can simply use the #cmd("chapter-nonum") function. This function assumes that you have a #sym.ast\.typ file per chapter.
#codesnippet[
	```typ
	#show: chapter-nonum

	// Content of the chapter
	= Chapter title
	```
]

== Tables of contents

The template defines several commands to facilitate the creation of tables of contents:
- #cmd("tableofcontents") : Table of contents
- #cmd("listoffigures") : List of figures
- #cmd("listoftables") : List of tables

A mini table of contents is automatically generated automatically by using the command #cmd("minitoc") in a chapter. This function is a wraper of the #cmd("suboutline") function provided by the `suboutline` package.

= Helper functions

== Figure captions

The package include the command #cmd("ls-caption") to manage long and short captions for figures and tables. Short caption are displayed in the list of figures or tables, while long captions are used in the main text and in the table of contents.

#codesnippet[
	```typ
	#figure(
  	rect(),
  	caption: ls-caption("Long caption", "Short caption")
	)
	```
]

#info-alert[The code of the command #cmd("ls-caption") comes from the #link("https://sitandr.github.io/typst-examples-book/book/snippets/chapters/outlines.html?highlight=long#long-and-short-captions-for-the-outline", "Typst book") by Sitandr.]

== Subfigures

In general, figures are inserted into the document using the #cmd("figure") function from #Typst. However, #Typst currently does not provide mechanisms for handling subfigures (numbering and referencing). To address this limitation, the template includes a #cmd("subfigure") function that manages subfigures appropriately. This function wraps the #cmd("subpar.grid") function from the `subpar` package.

#codesnippet[
	```typ
	#subfigure(
		figure(image("image1.png"), caption: []),
		figure(image("image2.png"), caption: []), <b>,
		columns: (1fr, 1fr),
		caption: [Figure title],
		label: <fig:subfig>,
	)
	```
]

#info-alert[The example above shows a figure composed of two subfigures. The first subfigure has a caption, while the second has a #dtype("label") but no title. The second subfigure can be referenced in the text using the command #text(`@b`, fill: typst-color.darken(15%)).]

== Equations

To highlight an important equation, use the #cmd("boxeq") function.

#codesnippet[
	```typ
	$
		#boxeq[$p(A|B) prop p(B|A) space p(A)$]
	$
	```
]

To create an equation without numbering, use the #cmd("nonumeq") function.

#codesnippet[
	```typ
	#nonumeq[$integral_0^1 f(x) dif x = F(1) - F(0)$]
	```
]

== Information boxes

The template provides several types of boxes to highlight different kinds of content:

- #cmd("info-box") for remarks;
- #cmd("tip-box") for tips;
- #cmd("warning-box") for warnings;
- #cmd("important-box") for important information;
- #cmd("proof-box") for proofs;
- #cmd("question-box") for questions.

#codesnippet[
	#show math.equation: set text(font: "Lete Sans Math")
	```typ
	#info-box[#lorem(10)]
	#tip-box[#lorem(10)]
	#warning-box[#lorem(10)]
	#important-box[#lorem(10)]
	#proof-box[#lorem(10)]
	#question-box[#lorem(10)]
	```
]

#info-alert[The appearance of the boxes depends on the selected theme (see the "Themes gallery" section).]

The information boxes described above are built using the #cmd("custom-box") function, which allows you to create custom boxes. This generic function takes the following parameters:
#command("custom-box",
..args(
	title: none,
	icon: "info",
	color: rgb(29, 144, 208),
	[body],
)
)[
	#argument("title", default: none, types: "string")[Name of the box.]

	#argument("icon", default: "info", types: "string")[Name of the icon to display in the box.

	Available icons are:
	- #box-title(image("../src/resources/images/icons/alert.svg", width: 1em), [: `"alert"`])
	- #box-title(image("../src/resources/images/icons/info.svg", width: 1em), [: `"info"`])
	- #box-title(image("../src/resources/images/icons/question.svg", width: 1em), [: `"question"`])
	- #box-title(image("../src/resources/images/icons/report.svg", width: 1em), [: `"report"`])
	- #box-title(image("../src/resources/images/icons/stop.svg", width: 1em), [: `"stop"`])
	- #box-title(image("../src/resources/images/icons/tip.svg", width: 1em), [: `"tip"`])
	]

	#argument("color", default: rgb(29, 144, 208), types: "color")[Box color.]
]

== Title pages

The template provides two functions to create title pages: one for a book and one for a thesis :

#command("book-page-title",
..args(
	subtitle: "Book subtitle",
  edition: "First edition",
  institution: "Institution",
  series: "Discipline",
  year: "2024",
  cover: none,
  logo: none,
	[body]
)
)[
	#argument("subtitle", default: "Book subtitle", types: "string")[Subtitle of the book.]

	#argument("edition", default: "First edition", types: "string")[Edition of the book.]

	#argument("institution", default: "Institution", types: "string")[Name of the institution.]

	#colbreak()
	#argument("series", default: "Discipline", types: "string")[Name of the series.]

	#argument("year", default: "2024", types: "string")[Year of publication.]

	#argument("cover", default: none, types: "image")[Cover image of the book.]

	#argument("logo", default: none, types: "image")[Logo of the book.]
]

#codesnippet[
```typ
#show: book.with(
	title-page: book-title-page(
		logo: image("path_to_logo/logo.png"),
		cover: image("path_to_image/book-cover.jpg")
	)
)
```
]

#command("thesis-page-title",
..args(
	type: "phd",
  school: "School name",
  doctoral-school: "Name of the doctoral school",
  supervisor: ("Supervisor name",),
  cosupervisor: none,
  laboratory: "Laboratory name",
  defense-date: "01 January 1970",
  discipline: "Discipline",
  specialty: "Speciality",
  committee: (:),
  logo: none,
	[body]
)
)[
	#argument("type", default: "phd", types: "string")[
		Type of thesis. Two values are possible:
		- `"phd"` for a doctoral thesis
		- `"hablitation"` for a French habilitation
	]

	#argument("school", default: "School name", types: "string")[Name of the institution where the thesis was prepared.]

	#argument("doctoral-school", default: "Name of the doctoral school", types: "string")[Name of the doctoral school.]

	#argument("supervisor", default: ("Supervisor name",), types: "array")[Name of the thesis supervisor(s) or the guarantor of the habilitation.]

	#argument("cosupervisor", default: none, types: "array")[Name of the thesis co-supervisor(s).]

	#argument("laboratory", default: "Laboratory name", types: "string")[Name of the research laboratory.]

	#argument("defense-date", default: "01 January 1970", types: "string")[Date of the thesis defense.]

	#argument("discipline", default: "Discipline", types: "string")[Name of the discipline.]

	#argument("specialty", default: "Speciality", types: "string")[Name of the specialty.]

	#argument("committee", default: (:), types: "array")[

		Name of the thesis committee members. Each element of the array is a #dtype(dictionary) with the following keys:
		- `name`: Name of the committee member.
		- `position`: Position of the committee member (e.g., "Associate Professor", "Professor", etc.).
		- `affiliation`: Affiliation of the committee member (e.g., "University Name").
		- `role`: Role of the committee member (e.g., "Chair", "Member", "Reviewer").

	]

	#argument("logo", default: none, types: "image")[Logo of the institution.]
]

#codesnippet(
```typ
#let committee = (
	(
		name: "Hari Seldon",
		position: "Full Professor",
		affiliation: "Streeling university",
		role: "President",
	),
	(
		name: "Gal Dornick",
		position: "Associate Professor",
		affiliation: "Synnax University",
		role: "Reviewer"
	),
)

#show: book.with(
	title-page: thesis-title-page(
		supervisor: ("Supervisor A", "Supervisor B"),
		cosupervisor: ("Co-supervisor A", "Co-supervisor B"),
		committee: committee
	)
)
```
)

#info-alert[For both title pages, the title of the document and its author are automatically generated based on the information given when initializing the template.]

== Back cover

A back cover of the document is automatically generated using the #cmd("back-cover") function, which displays information about the thesis (title and author), as well as a summary in French and English.

#command("back-cover", ..args(
	resume: none,
	abstract: none,
	logo: none
))[
	#argument("resume", types: "content")[Summary of the document in French.]

	#argument("abstract", types: "content")[Summary of the document in English.]

	#argument("logo", types: array)[Logo of the back cover.
	#codesnippet[
		```typ
		#let logos = (align(left)[#image("images/devise_cnam.svg", width: 45%)], align(right)[#image("images/logo_cnam.png", width: 50%)])

		#back-cover(lorem(10), lorem(10), logos)
		```
	]
	]
]

== Tufte layout <ss:tufte>

When the `tufte` layout is selected, several customizations are applied to adapt the appearance of various elements (figures, tables, equations, etc.) to the Tufte style.

#command("sidenote", ..args(
	dy: -1.5em,
	numbered: true,
	[body]
	)
)[
	#argument("dy", default: -1.5em, types: "length")[Vertical adjustment of the sidenote position.]

	#argument("numbered", default: true, types: "boolean")[Indicates whether the sidenote should be numbered.]
]

#info-alert[When the `layout` is set to `standard`, the #cmd("sidenote") function behaves like a standard #cmd("footnote").]

#command("sidecite", ..args(
	"key",
	dy: -1.5em,
	supplement: none,
))[
	#argument("key", types: "label")[Key of the reference to cite.]

	#argument("dy", default: -1.5em, types: "length")[Vertical adjustment of the sidecite position.]

	#argument("supplement", default: none, types: "string")[Supplementary text to add before the citation (e.g., "see", "e.g.", etc.).]
]

#info-alert[When the `layout` is set to `standard`, the #cmd("sidecite") function behaves like a standard #cmd("cite").]

#command("sidefigure", ..args(
	"content",
	dy: - 1.5em,
	label: none,
	caption: none,
))[
	#argument("content", types: "content")[Content of the figure.]

	#argument("dy", default: -1.5em, types: "length")[Vertical adjustment of the sidefigure position.]

	#argument("caption", default: none, types: "content")[Caption of the figure.]

	#argument("label", default: none, types: "label")[Label of the figure.]
]

#command("fullfigure", ..args(
	"content",
	label: none,
	caption: none,
))[
	#argument("content", types: "content")[Content of the figure.]

	#argument("caption", default: none, types: "content")[Caption of the figure.]

	#argument("label", default: none, types: "label")[Label of the figure.]
]

#info-alert[When the `layout` is set to `standard`, #cmd("sidefigure") and #cmd("fullfigure") behave like a standard #cmd("figure").]

= Theming

The theming system is designed to be flexible and customizable, allowing users to define their own themes.

To implement a custom theme, you have to define a function that includes the `show` and `set` rules defining the style of the document (headings, footnotes, references, #sym.dots). Basically, a theme should be structured as follows:
#codesnippet[
```typ
#import "bookly:0.2.0": *

#let my-theme(colors: default-colors, it) = {
	show heading.where(level: 1): it => {
		// Heading style
		...
	}

	show heading.where(level: 2): it => {
		// Heading style
		...
	}

	show heading.where(level: 3): it => {
		// Heading style
		...
	}

	show outline.entry: it => {
		// Outline entry style
		...
	}


	// Other show and set rules
	...

	it
}
```
]

You can also define your own functions such as #cmd("part"), #cmd("minitoc") and other elements of the document.

`bookly` provides some states that can be useful when designing a custom theme. The states are used to store information about the current state of the document. They are collected in a #dtype(dictionary). The following states are available:

#v(1em)
- `states.localization` -- #dtype(dictionary): Dictionary of terms used in the document (e.g., "chapter", etc.) in the selected language.

- `states.in-outline` -- #dtype(bool): Indicates whether the current section is in the outline.

- `states.isfrontmatter` -- #dtype(bool): Indicates whether the current section is front matter.

- `states.isappendix` -- #dtype(bool): Indicates whether the current section is an appendix.

- `states.num-pattern` -- #dtype(str): Numbering pattern for sections.

- `states.num-pattern-fig` -- #dtype(str): Numbering pattern for figures.

- `states.num-pattern-subfig` -- #dtype(str): Numbering pattern for subfigures.

- `states.num-pattern-eq` -- #dtype(str): Numbering pattern for equations.

- `states.num-heading` -- #dtype(str): Numbering pattern for headings.

- `states.page-numbering` -- #dtype(str): Numbering pattern for pages.

- `states.author` -- #dtype(str): Author of the document.

- `states.title` -- #dtype(str): Title of the document.

- `states.counter-part` -- #dtype(str): Counter for parts.

- `states.colors` -- #dtype(dictionary): Color scheme for the document.

- `states.theme` -- #dtype(str): Current theme of the document.

- `states.layout` -- #dtype(str): Current layout of the document.

- `states.sidenotecounter` -- #dtype(int): Counter for sidenotes.

#info-alert[
	`bookly` also comes with a function #cmd("reset-counters") to reset the counters for equations, figures, tables, sidenotes, and footnotes.
]

= Roadmap

The template is under development. Here is the list of features that are implemented or will be in a future version.

*Themes*

- [x] `fancy`
- [x] `modern`
- [x] `classic`
- [x] User-defined themes (requires a refactoring of the theming)

*Layout*

- [x] Standard layout
- [x] Tufte layout
// - [ ] User-defined paper and margins for `standard` and `tufte` layouts

*Cover pages*

- [x] Title page
- [x] Back cover

*Environments*

- [x] Creation of the `front-matter` environment
- [x] Creation of the `main-matter` environment
- [x] Creation of the `appendix` environment

*Parts and chapters*
- [x] Creation of a document `part` -- #cmd("part")
- [x] Creation of a document `chapter` -- #cmd("chapter")
- [x] Creation of an unnumbered `chapter` -- #cmd("chapter-nonum")

*Tables of contents*

- [x] Creation of the table of contents -- #cmd("tableofcontents")
- [x] Creation of the list of figures -- #cmd("listoffigures")
- [x] Creation of the list of tables -- #cmd("listoftables")
- [x] Creation of a mini table of contents at the beginning of chapters using the `suboutline` package (see #link("https://typst.app/universe/package/minitoc", text("link", fill: typst-color)))
- [x] Customization of entries (appearance, hyperlink) by modifying the `outline.entry` element
- [x] Localization of the different tables

*Figures and tables*

- [x] Customization of the appearance of figure and table captions depending on the context (chapter or appendix)
- [x] Short titles for the lists of figures and tables
- [x] Creation of the #cmd("subfigure") function for subfigures via the `subpar` package

*Equations*

- [x] Adaptation of equation numbering depending on the context (chapter or appendix)
- [x] Creation of a function to highlight important equations -- #cmd("boxeq")
- [x] Creation of a function to define equations without numbering -- #cmd("nonumeq")
- [x] Use of the `equate` package to number equations in a system like (1.1a)

*Boxes*

- [x] Creation of information boxes to highlight important content

*Bibliography*

- [x] Verification of the reference list via `bibtex`
- [x] Same for `hayagriva` (see #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md", text("documentation", fill: typst-color)))

