.PHONY: usage copy readme

usage:
	@echo "make <copy, readme>"

copy:
	bin/add.pl

readme:
	bin/readme.pl >README.md

all:
	copy
	readme
	git add -A
	git commit -m "add a pose"
	git push
