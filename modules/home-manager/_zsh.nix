{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ".." = "cd ..";
      cat = "bat --style=plain --theme=base16 --paging=never ";
      neofetch = "fastfetch";
      sudo = "sudo ";
      v = "vim ";
      gp = "git push";
      gc = "git commit";
    };
    # https://www.reddit.com/r/NixOS/comments/1lvptx5/comment/n28t5wm/
    # While the idea is kinda cool, it does in fact clutter the terminal e.g. when
    # running bat.
    #zsh-abbr = {
    #  enable = true;
    #  abbreviations = shellAliases; # <-- Use aliases
    #};
    # inspo: https://discourse.nixos.org/t/brew-not-on-path-on-m1-mac/26770/4
    initContent = ''
      if [[ $(uname -m) == 'arm64' ]] && [[ $(uname -s) == 'Darwin' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      #if [ -z "$SSH_AUTH_SOCK" ]; then
      #  eval "$(ssh-agent -s)" &> /dev/null
      #  ssh-add ~/.ssh/id_ed25519 &> /dev/null
      #fi

      cdr() {
        cd "$(git rev-parse --show-toplevel)"
      }
    '';

  };
}
