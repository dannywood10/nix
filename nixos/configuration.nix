{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # add each flake input as a registry
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    # add each flake input to legacy channels
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking.hostName = "nixos";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  users.users = {
    dannyw = {
      isNormalUser = true;
      description = "Danny wood";
      extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    };
  };
}