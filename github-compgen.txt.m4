divert(`-1')
# foreach(x, (item_1, item_2, ..., item_n), stmt)
#   parenthesized list, simple version
define(`foreach', `pushdef(`$1')_foreach($@)popdef(`$1')')
define(`_arg1', `$1')
define(`_foreach', `ifelse(`$2', `()', `',
  `define(`$1', _arg1$2)$3`'$0(`$1', (shift$2), `$3')')')
divert`'dnl
dnl
=: title _title_
=: description _description_

## Source-code:
=> _repo_url_

## Available PATHs

foreach(`_path_', (_paths_),`dnl
_path_
')dnl

## Available Commands

foreach(`_cmd_', (_commands_),`dnl
define(`_cmd_full_', esyscmd(printf "%s" $(which _cmd_ 2>/dev/null)))dnl
ifelse(_cmd_full_,,, _cmd_ -> _cmd_full_)dnl
')dnl
