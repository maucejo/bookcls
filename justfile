root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
	@just --list --unsorted

# generate manual
doc:
	typst compile docs/manual.typ docs/manual.pdf

# run test suite
test *args:
	typst-test run {{ args }}

# update test cases
update *args:
	typst-test update {{ args }}

# package the library into the specified destination folder
package target:
  ./scripts/package "{{target}}"

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# Create and shrink thumbnails
thumbnails:
  typst c template/main.typ thumbnails/{n}.png --root ./ --font-path ./
  oxipng -o 4 --strip safe --alpha thumbnails/*.png

example:
  typst c template/main.typ example.pdf --root ./ --font-path ./

# run ci suite
ci: test doc thumbnails example
