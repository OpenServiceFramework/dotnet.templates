TMPLS := 95classlib 95console 95grpc 95web 95worker

.PHONY: all $(TMPLS)

all: $(TMPLS)

$(TMPLS):
	@cp -rv ./common/* ./$@
	@cp -rv ./common/.gitignore ./$@

