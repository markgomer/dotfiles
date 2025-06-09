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
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # stable banch
    
    #nerd-fonts.jetbrains-mono # unstable 
    #nerd-fonts.fira-code # unstable
    #nerd-fonts.fantasque-sans-mono #unstable
 	];
}
