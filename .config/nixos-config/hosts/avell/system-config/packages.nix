# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, ...}:

{
  # System Packages
  environment.systemPackages = (with pkgs; [
    bc
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    fastfetch
    findutils
    ffmpeg   
    glib #for gsettings to work
    gsettings-qt
    git
    killall  
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    wget
    xdg-user-dirs
    xdg-utils

    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
  ]);
}
