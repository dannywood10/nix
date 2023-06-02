{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
  ];

  nixpkgs = {

    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "dannyw";
    homeDirectory = "/home/dannyw";
  };

  home.packages = with pkgs; [
    firefox-devedition-bin
    kitty
    slack
    
    act
    awscli2
    btop
    docker
    docker-compose
    dot
    gh
    git
    nodePackages.npm
    nodejs
    openssh
    postgresql
    terraform
    terraform-ls
    tflint
    tree
    tmux
    unrar
    unzip
    wget
    yarn
    zip
    #
    vscode
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        esbenp.prettier-vscode
        bbenoist.nix
        ms-azuretools.vscode-docker
      # ms-vscode-remote.remote-containers
      # amazonwebservices.aws-toolkit-vscode 
        hashicorp.terraform
      # christian-kohler.npm-intellisense
      ];
    })
  ];
  
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.11";
}
