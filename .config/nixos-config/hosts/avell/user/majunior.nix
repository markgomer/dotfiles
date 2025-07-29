# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
  nixCfgDir = "$HOME/dotfiles/.config/nixos-config";
  inherit (import ../variables.nix) gitUsername;
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
        "plugdev"
      ];
      packages = with pkgs; [
        bat
        eza
        fd
        lazygit
        ripgrep
        stow
        zellij
      ];
    };
    defaultUserShell = pkgs.zsh;
  }; 

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      alacritty
      distrobox
      lsd
      fzf
    ];
  };

}
