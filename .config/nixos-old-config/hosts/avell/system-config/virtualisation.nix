{
  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    # defaultNetwork.settings.dns_enabled = false;
  };

  programs.virt-manager.enable = false;
}
