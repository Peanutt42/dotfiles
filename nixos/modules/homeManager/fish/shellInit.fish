set fish_greeting ""

set --global fish_user_paths $fish_user_paths $HOME/.local/bin $HOME/.opencode/bin

# fixes problem with `nix develop` where it runs bash instead of fish
function nix
	if test (count $argv) -ge 1 -a "$argv[1]" = "develop"
		command nix $argv --command fish
	else
		command nix $argv
	end
end

source "$HOME/.cargo/env.fish"
