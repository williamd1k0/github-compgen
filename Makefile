space := ${eval} ${eval}
comma := ,
cmd_file := commands.txt
cmd_sources := $(sort $(shell cat ${cmd_file}))
cmd_define := $(subst ${space},${comma},${cmd_sources})

${cmd_file}:
	bash -c "compgen -c | sort -u > $@"

%.md: %.md.m4 ${cmd_file}
	m4 -D_commands_=${cmd_define} $< > $@

.PHONY:	${cmd_file}
