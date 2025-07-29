{ pkgs, ... }:
let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
      ]
  );

in
{
  programs = {
    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
  	  xwayland.enable = true;
    };
	  waybar.enable = true;
	  hyprlock.enable = true;
  };

  environment.systemPackages = (with pkgs; [
    # Hyprland Stuff
    ags # desktop overview
    brightnessctl # for brightness control
    cava
    cliphist
    loupe
    gnome-system-monitor
    grim
    gtk-engine-murrine #for gtk themes
    hypridle
    hyprshot
    hyprland-qtutils
    imagemagick
    inxi
    jq
    kitty
    libqalculate
    libsForQt5.qtstyleplugin-kvantum #kvantum
    networkmanagerapplet
    nwg-displays
    nwg-look
    mako
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    libsForQt5.qt5ct
    openssl #required by Rainbow borders
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
    swaybg
    swaynotificationcenter
    swayosd
    swww
    walker
    wallust
    wl-clipboard
    wlogout

    waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];
}
