{ pkgs, ... }:
{
  powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };

  environment.systemPackages = (with pkgs; [
    linuxKernel.packages.linux_6_6.cpupower
  ]);
}
