{ pkgs, ...}:

{
  # System Packages
  environment.systemPackages = (with pkgs; [
    bash-completion
    bc
    btrfs-progs
    btop
    clang
    curl
    cpufrequtils
    duf
    fastfetch
    findutils
    ffmpeg
    glib # for gsettings to work
    gsettings-qt
    killall
    libappindicator
    libnotify
    nvtopPackages.full
    pciutils
    man
    neovim
    tldr
    unzip
    undervolt
    xarchiver
    wget
    xdg-user-dirs
    xdg-utils
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
  ]);
}
