{ config, lib, options, modulesPath, users, pkgs, environment }: 

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wjjunyor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "adbusers" ];
    home = "/home/wjjunyor";
    description = "Walter Queiroz";
    uid = 1000;
  };
  
  users.users.caroles = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "adbusers" ];
    home = "/home/caroles";
    description = "Carolina Queiroz";
    uid = 2000;
  };

}
