{ pkgs, ... }:
{
  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # 24.11
    (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # 24.11
    (nerdfonts.override {fonts = ["CaskaydiaMono"];}) # 24.11

    # for 25.05 onwards
    #nerd-fonts.jetbrains-mono
    #nerd-fonts.fira-code
    #nerd-fonts.fantasque-sans-mono
 	];
}
