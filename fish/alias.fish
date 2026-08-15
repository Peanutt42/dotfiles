abbr -a vim nvim
abbr -a nv nvim
abbr -a v nvim

abbr -a lg lazygit

# eza - ls alternative
if command -q ls
    alias rls (command -v ls)
end
alias ls _fish_eza_ls
alias la 'eza -lbhHigUmuSa' # List all with details
alias lx 'eza -lbhHigUmuSa@' # List all, with additional file attributes
alias l _fish_eza_l # List files respecting .gitignore
alias ll _fish_eza_ll # Long listing format with all files and header
alias llm _fish_eza_llm # Long listing sorted by modification time
alias lt _fish_eza_lt # Tree view with 2-level depth limit 
alias tree _fish_eza_tree # Tree view with unlimited depth
