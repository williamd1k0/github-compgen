space := ${eval} ${eval}
comma := ,
_title_ := GitHub Compgen
_description_ := A list of all commands available in the GitHub Actions image (ubuntu-latest).
_repo_url_ := https://github.com/williamd1k0/github-compgen
path_file := paths.txt
path_sources = $(sort $(shell cat ${path_file}))
path_define = $(subst ${space},${comma},${path_sources})
cmd_file := commands.txt
cmd_sources = $(sort $(shell cat ${cmd_file}))
cmd_define = $(subst ${space},${comma},${cmd_sources})
static_defines := -D_title_='${_title_}' -D_description_='${_description_}' -D_repo_url_='${_repo_url_}'

${path_file}:
	@for path in $(subst :,${space},${PATH}); do \
		echo $$path >> ${path_file}; \
	done

${cmd_file}:
	@bash -c "compgen -c | sort -u > $@"

sources: ${cmd_file} ${path_file}

%.md: %.md.m4 ${cmd_file} ${path_file}
	@m4 ${static_defines} -D_paths_=${path_define} -D_commands_=${cmd_define} $< > $@

github-compgen.txt: github-compgen.txt.m4 ${cmd_file} ${path_file}
	@m4 ${static_defines} -D_paths_=${path_define} -D_commands_=${cmd_define} $< > $@

clean:
	rm -f -- "${path_file}" "${cmd_file}"

.PHONY: clean