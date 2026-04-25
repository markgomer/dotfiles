{
  imports = [
    ./amd-drivers.nix
    ./intel-drivers.nix
    ./nvidia-drivers.nix
    ./nvidia-prime-drivers.nix
  ];

  # Extra Module Options
  drivers.amdgpu.enable = true;
  drivers.intel.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
}
