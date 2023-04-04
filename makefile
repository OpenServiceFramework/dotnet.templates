TMPLS := osf.classlib osf.console osf.grpc osf.web osf.worker

.PHONY: all $(TMPLS)

all: $(TMPLS)

$(TMPLS):
	@cp -rv ./common/* ./$@
	@cp -rv ./common/.github ./$@
	@cp -rv ./common/.gitignore ./$@
	@cp -rv ./common/.editorconfig ./$@
	@cp -rv ./common/.dockerignore ./$@
