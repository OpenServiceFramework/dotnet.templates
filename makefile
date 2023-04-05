TMPLS := osf.classlib osf.console osf.grpc osf.web osf.worker

.PHONY: all $(TMPLS)

all: $(TMPLS)

$(TMPLS):
	@cp -rv ./common/* ./templates/$@
	@cp -rv ./common/.gitignore ./templates/$@
	@cp -rv ./common/.editorconfig ./templates/$@
	@cp -rv ./common/.dockerignore ./templates/$@

install:
	@dotnet new install osf.dotnet.templates
