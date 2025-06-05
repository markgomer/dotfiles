{
  imports = [
    ./drivers
    ./hardware-configuration.nix
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
