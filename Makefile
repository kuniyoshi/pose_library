.PHONY: usage copy readme

usage:
	@echo "make <copy, readme>"

copy:
	bin/add.pl

readme:
	bin/readme.pl >README.md
