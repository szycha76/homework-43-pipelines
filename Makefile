
GH		:= git@github.com:szycha76
PFX		:= homework-43
SUFFIXLIST	:= repoA repoC pipelines
R		:= $(PFX)-pipelines  # One repo to rule them all
REPOLIST	:= $(foreach sfx,$(SUFFIXLIST),$(PFX)-$(sfx))
TASKS		:= B C D
TASKLIST	:= $(foreach T,$(TASKS),task$(T))
AUTOFILES	:= Jenkinsfile README.md


help: 
	@echo Available goals
	@echo ---------------------------------------------------------------------
	@grep -E ": .*[#]{2}" Makefile | sed 's/:.*[#]\{2\}/\t\t/'
	@echo ---------------------------------------------------------------------


j:
	@docker build -t j .

rj:
	@docker run --rm -p 8080:8080 -p 50000:50000 -v JENKINS_HOME:/var/jenkins_home j

rmj: j
	@docker run --user root --rm -it j /bin/bash

# All the below should be executed only once

first-time-init: clone-them-all $(TASKLIST) ## One-off action to init the workspace
	@cd $(R); git branch -m master "master-$$(date +%Y-%m%d-%H%M%S)" || echo " ((( that's OK ))) "
	@cd $(R); git checkout --orphan master; git branch -M master; git rm -rf .; /bin/rm -f $(AUTOFILES)
	@mv Makefile $(R); cd $(R); echo "$$gitignore" > .gitignore; \
		git add .; git commit -m '$@'; git push --force -u origin master; \
		for T in $(TASKLIST); do \
			git push --force -u origin $$T; done

clone-them-all: $(REPOLIST) ## Clone the repositories

homework%:
	@if [[ ! -d ../$@ ]] && [[ ! -d ../../$@ ]]; then git clone $(GH)/$@; fi

task%: $(R)
	@cd $<; git rev-parse --verify $@ && exit 0 || echo ' >>> ' Branch $@ does not exits yet, we can continue; \
	git checkout --orphan $@; git rm -rf .; /bin/rm -f $(AUTOFILES); \
	echo ' *** ' Current branch is: $$(git branch --show-current), should be: $@; \
	if [[ "$@" == "taskD" ]]; then \
		echo "$$MD" > README.md; \
	else \
		echo "$$J" > Jenkinsfile; \
	fi; \
	echo "$$gitignore" > .gitignore; git add . || echo ok; git commit -m 'Initial automatic commit to branch $@'

hard-reset: $(R) ## Wipe out master repository (DANGEROUS)
	@read -p 'Type "YES" to wipe out repository "$<" > ' junk; if [[ "$$junk" == "YES" ]]; then \
		if [[ ! -d .git ]]; then cd "$<"; fi; git checkout master; \
		git branch -D $(TASKLIST) || echo ' --- ' ignoring above branch removal errors on local repository; \
		for b in $(TASKLIST); do git push +u origin :$$b || echo ' +++ ' ignoring above branch "'$$b'" removal errors on remote repository; done \
	fi
	$(MAKE) first-time-init

.PHONY: clone-them-all first-time-init

define J =
/*
 * This is automatically generated Jenkinsfile for $@
 */

endef

define MD =
# Welcome!

This repository holds the following branches:
- `taskB` for pipelineB
- `taskC` for pipelineC
- `taskD` for README.md (the file you're reading)
- `master` - for Makefile that made this homework much easier

endef

define gitignore =
*~
*.sw[a-p]
endef

export J MD gitignore
