space := ${eval} ${eval}
comma := ,
define nl


endef
_title_ := GitHub Compgen
_description_ := A list of all commands available in the GitHub Actions image (ubuntu-latest).
_repo_url_ := https://github.com/williamd1k0/github-compgen
cmd_file := commands.txt
cmd_sources := $(sort $(shell cat ${cmd_file}))
cmd_define := $(subst ${space},${comma},${cmd_sources})
static_defines := -D_title_='${_title_}' -D_description_='${_description_}' -D_repo_url_='${_repo_url_}'

${cmd_file}:
	bash -c "compgen -c | sort -u > $@"

%.md: %.md.m4 ${cmd_file}
	m4 ${static_defines} -D_commands_=${cmd_define} $< > $@

github-compgen.txt: github-compgen.txt.m4
	m4 ${static_defines} -D_commands_=${cmd_define} $< > $@

.PHONY:	${cmd_file}
