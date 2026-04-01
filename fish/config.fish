if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

set PATH "$HOME/.local/bin:$PATH"

starship init fish | source

zoxide init fish --cmd cd | source


# fixes problem with `nix develop` where it runs bash instead of fish
# Solution: replace `nix develop` with `nix develop --command fish`
function nix
    if test (count $argv) -ge 1 -a "$argv[1]" = "develop"
        command nix $argv --command fish
    else
        command nix $argv
    end
end

# opencode
fish_add_path /home/peter/.opencode/bin

# tmux-sessionizer
COMPLETE=fish tms | source
