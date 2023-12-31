{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    dirHashes = {
      cfg = "$HOME/.config";
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      nx = "$HOME/nixos";
      nxh = "$HOME/nixos/home-manager";
      nxp = "$HOME/nixos/home-manager/programs";
      nxs = "$HOME/nixos/home-manager/services";
      nxx = "$HOME/nixos/scripts";
      nxv = "$HOME/nixos/nixvim";
      pics = "$HOME/Pictures";
      repos = "$HOME/repos";
      vids = "$HOME/Videos";
    };
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      size = 20000;
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = [ "^j" ];
      searchUpKey = [ "^k" ];
    };
    shellAliases = {
      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
      "......." = "cd ../../../../../../";
      "........" = "cd ../../../../../../../";
      "........." = "cd ../../../../../../../../";
      ".........." = "cd ../../../../../../../../../";
      batt = "bat /sys/class/power_supply/BAT1/capacity";
      chrome = "google-chrome-stable";
      clock = "tty-clock -bcsC4 -f %a,\\ %d\\ %b\\ %Y";
      cfg = "nvim ~/nixos/configuration.nix";
      df = "df -h";
      flake = "nix flake update";
      free = "free -mth";
      gaa = "git add --all";
      gac = "git add --all && git commit -m";
      gb = "git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
      gbd = "git branch -D";
      gbD = "git push origin --delete";
      gcam = "git add --all && git commit --amend";
      gcb = "git checkout -b";
      gcm = "git commit -m";
      gco = "git checkout";
      gcod = "git checkout $(git_develop_branch)";
      gcof = "git checkout --";
      gcom = "git checkout $(git_main_branch)";
      gd = "git diff";
      gdn = "git diff --name-only";
      gfp = "git fetch --all --prune && git pull --rebase origin $(git symbolic-ref --short HEAD)";
      ggf = "git push --force origin $(git symbolic-ref --short HEAD)";
      ggp = "git push origin $(git symbolic-ref --short HEAD)";
      glo = "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      gpp = "git pull --rebase origin $(git symbolic-ref --short HEAD) && git push origin $(git symbolic-ref --short HEAD)";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      gsb = "git status -sb";
      gc = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      grep = "grep --color=auto";
      history = "history -i";
      lsblk = "lsblk -f";
      man = "batman";
      mkdir = "mkdir -p";
      n = "nvim";
      nf = "nvim ~/nixos/flake.nix";
      nxh = "nvim ~/nixos/home-manager/default.nix";
      nxv = "nvim ~/nixos/nixvim/default.nix";
      pow = "sudo shutdown now";
      reb = "sudo reboot now";
      rebuild = "nix flake update && sudo nixos-rebuild switch --flake '.#hyprnova' --upgrade";
      sn = "sudo -Es nvim";
      tree = "tree -ad --gitignore -C -L 2";
      zk = "zk --working-dir=yggdrasil";
    };
    initExtra = ''
      setopt always_to_end
      setopt append_history
      setopt auto_list
      setopt auto_menu
      setopt auto_pushd
      setopt complete_in_word
      setopt hist_find_no_dups
      setopt hist_reduce_blanks
      setopt hist_save_no_dups
      setopt inc_append_history
      setopt menu_complete

      _comp_options+=(globdots)

      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      zle -N zsh-backward-kill-word

      zstyle ':completion:*:*:*:*:*' menu select
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' list-colors ""
      zstyle ':completion::complete:*' gain-privileges 1

      if [[ "$CASE_SENSITIVE" = true ]]; then
        zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
      else
        if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
          zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
        else
          zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
        fi
      fi

      unset CASE_SENSITIVE HYPHEN_INSENSITIVE

      bindkey -e
      bindkey "^[[3~" delete-char
      bindkey "^[[5~" beginning-of-buffer-or-history
      bindkey "^[[6~" end-of-buffer-or-history
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[OA" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search
      bindkey "^[OB" down-line-or-beginning-search
      bindkey '^w' zsh-backward-kill-word

      eval "$(op completion zsh)"; compdef _op op
    '';
    initExtraBeforeCompInit = ''
      autoload -Uz up-line-or-beginning-search
      autoload -Uz down-line-or-beginning-search
    '';
    initExtraFirst = ''
      git_develop_branch () {
        command git rev-parse --git-dir &>/dev/null || return
        local branch
        for branch in dev devel development; do
          if command git show-ref -q --verify refs/heads/$branch; then
            echo $branch
            return
          fi
        done
        echo develop
      }

      git_main_branch () {
        command git rev-parse --git-dir &>/dev/null || return
        local ref
        for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
          if command git show-ref -q --verify $ref; then
            echo ''${ref:t}
            return
          fi
        done
        echo master
      }

      zsh-backward-kill-word () {
        local WORDCHARS=""
        zle -f kill
        zle backward-kill-word
      }
    '';
  };
}
