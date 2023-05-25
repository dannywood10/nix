{ pkgs }: {
  users.users = {
    dannyw = {
      isNormalUser = true;
      description = "Danny wood";
      extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    }
  };
}
