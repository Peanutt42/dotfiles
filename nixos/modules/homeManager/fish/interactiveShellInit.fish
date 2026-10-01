COMPLETE=fish tms | source

gwq completion fish | source

set --erase --universal fish_key_bindings

set --global fish_color_autosuggestion 555 brblack
set --global fish_color_cancel -r
set --global fish_color_command 005fd7
set --global fish_color_comment 990000
set --global fish_color_cwd green
set --global fish_color_cwd_root red
set --global fish_color_end 009900
set --global fish_color_error ff0000
set --global fish_color_escape 00a6b2
set --global fish_color_history_current --bold
set --global fish_color_host normal
set --global fish_color_host_remote yellow
set --global fish_color_normal normal
set --global fish_color_operator 00a6b2
set --global fish_color_param 00afff
set --global fish_color_quote 999900
set --global fish_color_redirection 00afff
set --global fish_color_search_match white --background=brblack
set --global fish_color_selection white --bold --background=brblack
set --global fish_color_status red
set --global fish_color_user brgreen
set --global fish_color_valid_path --underline
set --global fish_pager_color_completion
set --global fish_pager_color_description B3A06D yellow
set --global fish_pager_color_prefix normal --bold --underline
set --global fish_pager_color_progress brwhite --background=cyan
set --global fish_pager_color_selected_background -r

# make man output colorful
# annotated by dave eddy (@yousuckatprogramming)
# explained - https://youtu.be/D0sG2fj0G4Y
# borrowed heavily from https://grml.org
# converted to fish syntax
set -x LESS_TERMCAP_mb (printf '\e[1;31m')
set -x LESS_TERMCAP_md (printf '\e[1;31m')
set -x LESS_TERMCAP_me (printf '\e[0m')
set -x LESS_TERMCAP_se (printf '\e[0m')
set -x LESS_TERMCAP_so (printf '\e[1;33;44m')
set -x LESS_TERMCAP_ue (printf '\e[0m')
set -x LESS_TERMCAP_us (printf '\e[4;1;32m')
set -x LESS_TERMCAP_mr (printf '\e[7m')
set -x LESS_TERMCAP_mh (printf '\e[2m')
set -x LESS_TERMCAP_ZN (printf '\e[74m')
set -x LESS_TERMCAP_ZV (printf '\e[75m')
set -x LESS_TERMCAP_ZO (printf '\e[73m')
set -x LESS_TERMCAP_ZW (printf '\e[75m')
set -x MANPAGER 'less'
set -x MANROFFOPT '-c'
set -gx GROFF_NO_SGR 1
