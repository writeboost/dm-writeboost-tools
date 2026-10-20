CARGO ?= cargo
PREFIX ?= /usr/local
DESTDIR ?=
SUDO ?= sudo

.PHONY: all install

all:
	$(CARGO) build --release --locked

install:
	@set -eu; \
	stage=$$(mktemp -d); \
	trap 'rm -rf -- "$$stage"' EXIT; \
	trap 'exit 1' HUP INT TERM; \
	$(CARGO) install --locked --path writeboost-cli --bin writeboost-cli --root "$$stage"; \
	$(SUDO) install -D -m 755 -- "$$stage/bin/writeboost-cli" "$(DESTDIR)$(PREFIX)/bin/writeboost-cli"
