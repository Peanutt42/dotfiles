# ctrl+backspace
bind \b 'backward-kill-word'

# ctrl+del
bind \e\[3\;5~ 'kill-word'


# ctrl+f for tmux-sessionizer
function __tmux_sessionizer_bind
    commandline -r "tms"
    commandline -f execute
end
bind \cf __tmux_sessionizer_bind
