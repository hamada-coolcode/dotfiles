nitch

# fish
set fish_greeting ""
fish_config theme choose "Catppuccin Frappe"
oh-my-posh init fish --config "https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catppuccin.omp.json" | source

# aliases
alias clear="clear && source ~/.config/fish/config.fish"
alias ls="eza -hmluU --git --total-size"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# yazi

function yz
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

# mpvpaper
mpvpaper -o "--mute=yes --loop-file=inf" DP-1 ~/Videos/#.mp4

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"
set -x PATH $PATH (go env GOPATH)/bin
set -gx PATH $HOME/.nimble/bin $PATH
