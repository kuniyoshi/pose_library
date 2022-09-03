.PHONY: copy readme

copy:
	bin/add.pl

readme:
	bin/readme.pl >README.md
