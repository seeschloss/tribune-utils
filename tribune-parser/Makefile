DC=$(shell which ldc2 || which gdc || which dmd)
PREFIX=/usr/local

BINDIR=bin
DOCDIR=doc
SRCDIR=src
BUILDDIR=build
SOURCES=$(shell find $(SRCDIR) -type f -name '*.d')
DLIBS=curl

all: $(BINDIR)/tribune-parser

$(BINDIR)/%: $(SOURCES)
	mkdir -p $(BINDIR)
ifneq (,$(findstring gdc,$(DC)))
	$(DC) $(foreach lib, $(DLIBS), -l$(lib)) \
		-I$(SRCDIR) -O3 \
		-o$@ \
		$(SOURCES)
else
	mkdir -p $(BUILDDIR)
	$(DC) $(foreach lib, $(DLIBS), -L-l$(lib)) \
		-od$(BUILDDIR) \
		-I$(SRCDIR) -O -release \
		-of$@ \
		$(SOURCES)
endif

install: $(BINDIR)/tribune-parser
	install -D $(BINDIR)/tribune-parser $(PREFIX)/bin/tribune-parser
	strip -s $(PREFIX)/bin/tribune-parser

uninstall:
	rm -f $(PREFIX)/bin/tribune-parser

clean:
	rm -rf $(BUILDDIR)
	rm -rf $(BINDIR)
