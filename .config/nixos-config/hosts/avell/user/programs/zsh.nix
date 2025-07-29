let
  nixCfgDir = "$HOME/dotfiles/.config/nixos-config";
in
{
  programs = {
	  zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = false;
        plugins = ["git"];
        theme = "agnoster"; 
      };
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 
      '';

      shellAliases = {
        # ls = "eza --icons=always";

        fullClean = '' 
            nix-collect-garbage --delete-old

            sudo nix-collect-garbage -d

            sudo /run/current-system/bin/switch-to-configuration boot
        '';

        btw = "echo i use nixos btw";
        nrs = "sudo nixos-rebuild switch --flake ${nixCfgDir}#avell";
        nlg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        ngc = "nix-collect-garbage";
        nso = "nix-store --optmise";
        update = "cd ${nixCfgDir} && nix flake update";
        ecf = "nvim ${nixCfgDir}/flake.nix";
        sv = "~/.local/scripts/powersave.sh";
        eq = "$HOME/.local/scripts/equilibrado.sh";
        pw = "$HOME/.local/scripts/performance.sh";
      };
    };
  };
}
