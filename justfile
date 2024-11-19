package target:
  ./scripts/package "{{target}}"

install:
  ./scripts/package "@local"

install-preview:
  ./scripts/package "@preview"

# uninstalls the library from the "@local" prefix
uninstall:
  ./scripts/uninstall "@local"

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview:
  ./scripts/uninstall "@preview"

thumbnails:
  typst c template/main.typ thumbnails/{n}.png --root ./ --font-path ./
  oxipng -o 4 --strip safe --alpha thumbnails/*.png