# Makefile for Nim project (2023-12-09).

NIM       ?= nim
NIMBLE    ?= nimble
TESTAMENT ?= testament
RMDIR     ?= rmdir
PYTHON    ?= python3

PACKAGE_NAME = $(basename $(wildcard *.nimble))

EXAMPLES ?= $(patsubst %.nim, %, $(wildcard examples/*.nim))

ifeq ($(VERBOSE),1)
V :=
else
V := @
endif

.DEFAULT_GOAL := help

all:

.PHONY: help
help:
	@echo "Usage: $(MAKE) <target>"
	@echo
	@echo "Targets:"
	@grep -E '^[a-z]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: check
check:	## verify nimble package
	$(V)$(NIMBLE) check
	$(V)$(NIM) check --hint:name:off --styleCheck=hint src/$(PACKAGE_NAME).nim

.PHONY: examples
examples:
	$(V)$(NIMBLE) $@

.PHONY: check
test:	## run tests
	$(V)$(TESTAMENT) all

.PHONY: doc
doc:	## generate package documentation
	$(V)$(NIMBLE) gendoc

.PHONY: install
install:	## install the package
	$(V)$(NIMBLE) install

.PHONY: force-install
force-install:	## force install the package
	$(V)$(NIMBLE) install -y

.PHONY: uninstall
uninstall:	## uninstall the package
	-$(V)$(NIMBLE) uninstall $(PACKAGE_NAME)

.PHONY: uninstall
force-uninstall:	## force uninstall the package
	-$(V)$(NIMBLE) -y uninstall $(PACKAGE_NAME)

.PHONY: reinstall
reinstall: uninstall install	## reinstall the package

.PHONY: force-reinstall
force-reinstall: force-uninstall install	## force reinstall the package

.PHONY: clean
clean:
	-$(V)$(RM) $(basename $(wildcard tests/*/test_*.nim))
	-$(V)$(RM) tests/megatest.nim tests/megatest

.PHONY: distclean
distclean: clean
	-$(V)$(RM) -rf nimcache/
	-$(V)$(RM) -rf testresults/
	-$(V)$(RM) outputExpected.txt outputGotten.txt testresults.html

.PHONY: watchdoc
watchdoc:
	$(MAKE) doc
	$(V)inotifywait -e close_write --recursive --monitor --format '%e %w%f' src | \
		while read change; do \
			$(MAKE) doc; \
		done

.PHONY:
serve:
	$(V)$(PYTHON) -m http.server -d /tmp/nimdoc

arch: clean
	$(V)set -e; \
		project=`basename \`pwd\``; \
		timestamp=`date '+%Y-%m-%d-%H%M%S'`; \
		destfile=../$$project-$$timestamp.tar.zst; \
		tar -C .. -caf $$destfile $$project && chmod 444 $$destfile; \
		echo -n "$$destfile" | xclip -selection clipboard -i; \
		echo "Archive is $$destfile"

# vim: set ts=8 noet sts=8:
