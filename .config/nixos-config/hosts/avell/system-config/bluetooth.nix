

{
  environment.systemPackages = (with pkgs; [
    blueberry
  ])

  # Bluetooth
  hardware = {
  	bluetooth = {
	    enable = true;
	    powerOnBoot = true;
	    settings = {
		    General = {
		      Enable = "Source,Sink,Media,Socket";
		      Experimental = true;
		    };
      };
    };
  };
}
