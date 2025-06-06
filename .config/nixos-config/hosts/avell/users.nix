# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;
  nixCfgDir = "~/dotfiles/.config/nixos-config";
in
{
  users = { 
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video" 
        "input" 
        "audio"
        "users"
      ];

      # define user packages here
      packages = with pkgs; [
        bat
        eza
        lunarvim
        ripgrep
        asdf-vm
        lazygit
        tmux
        tmux-sessionizer
      ];
    };

    defaultUserShell = pkgs.zsh;
  }; 

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    lsd
    fzf
  ]; 
    
  programs = {
    # Zsh configuration
	  zsh = {
    	enable = true;
	  	enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "agnoster"; 
      };
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      promptInit = ''
        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # Set-up icons for files/directories in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
      '';

      shellAliases = {
        ls = "eza --icons=always";

        fullClean = '' 
            nix-collect-garbage --delete-old

            sudo nix-collect-garbage -d

            sudo /run/current-system/bin/switch-to-configuration boot
        '';

        btw = "echo i use nixos btw";
        nrs = "sudo nixos-rebuild switch --flake ${nixCfgDir}#avell";
        nhr = "home-manager switch --flake ${nixCfgDir}#majunior";
        nfr = "nrs && nhr";
        nlg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        ngc = "nix-collect-garbage";
        nso = "nix-store --optmise";
        update = "cd ${nixCfgDir} && nix flake update";
        ecf = "lvim ${nixCfgDir}";
        sv = "~/.local/scripts/powersave.sh";
        eq = "$HOME/.local/scripts/equilibrado.sh";
        pw = "$HOME/.local/scripts/performance.sh";
      };
    };
  };
}
