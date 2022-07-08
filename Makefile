space := ${eval} ${eval}
comma := ,

image_ref := $(shell git branch --show-current)
D_title_ := GitHub Compgen
D_description_ := A list of all commands available in the GitHub Actions image (${image_ref}).
D_repo_url_ := https://github.com/williamd1k0/github-compgen
static_defines := -D_title_='${D_title_}' -D_description_='${D_description_}' -D_repo_url_='${D_repo_url_}'

path_file := paths.txt
path_sources = $(sort $(shell cat ${path_file}))
D_paths = $(subst ${space},${comma},${path_sources})
cmd_file := commands.txt
cmd_sources = $(sort $(shell cat ${cmd_file}))
D_commands = $(subst ${space},${comma},${cmd_sources})

${path_file}:
	@for path in $(subst :,${space},${PATH}); do \
		echo $$path >> ${path_file}; \
	done

${cmd_file}:
	@bash -c "compgen -c | sort -u > $@"

sources: ${cmd_file} ${path_file}

%.md: %.md.m4 ${cmd_file} ${path_file}
	@m4 ${static_defines} -D_paths_=${D_paths} -D_commands_=${D_commands} $< > $@

github-compgen.txt: github-compgen.txt.m4 ${cmd_file} ${path_file}
	@m4 ${static_defines} -D_paths_=${D_paths} -D_commands_=${D_commands} $< > $@

clean:
	rm -f -- "${path_file}" "${cmd_file}"

.PHONY: clean sources