# Aliases
alias serve='python3 -m http.server'
alias dc="UID=\"$(id -u)\" GID=\"$(id -g)\" docker compose"
alias dcu="dc up"
alias dcd="dc down"
alias dcb="dc build"
alias dcud="dcu -d"
alias dck="dc kill"
alias dclf="dc logs -f"
alias dcL="dclf --tail 300"
alias lrt="eza -l -snew --icons"
alias vi="nvim"
alias vim="nvim"
## Kitty alias
alias ssh="kitten ssh"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Update PATH
fish_add_path /Users/bgaze/.local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
## orbstack/docker
fish_add_path ~/.orbstack/bin
# Postgres
fish_add_path /opt/homebrew/opt/libpq/bin

# Load local cfg and secrets
if test -e ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
if test -e ~/.config/fish/secret.fish
    source ~/.config/fish/secret.fish
end

# Fish theme
# fish_config theme choose "Rose Pine Moon"
source ~/.config/fish/themes/tokyonight_moon.fish

# Zoxide
zoxide init fish | source

# Fish greeting
function fish_greeting
    echo "Welcome to 🐟🐠🐡"
    echo ""
    fastfetch
end

# Fzf theme
## Catppuccin Frappe theme
# set -Ux FZF_DEFAULT_OPTS "\
# --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
# --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
# --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
# --color=selected-bg:#51576d \
# --multi"
## Rose pine Moon
# set -Ux FZF_DEFAULT_OPTS "
# 	--color=fg:#908caa,bg:#232136,hl:#ea9a97
# 	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
# 	--color=border:#44415a,header:#3e8fb0,gutter:#232136
# 	--color=spinner:#f6c177,info:#9ccfd8
# 	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

## Tokyonight Moon
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"
