{
  pkgs,
  vars,
  ...
}:
{
  imports = [
    ./_packages.nix
  ];

  wsl = {
    enable = true;
    defaultUser = vars.userName;
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  users.users.${vars.userName} = {
    isNormalUser = true;
    description = vars.userName;
    shell = pkgs.zsh;
    linger = true;
  };

  home-manager.users.${vars.userName} = {
    programs = {
      zsh.shellAliases = {
        ssh = "ssh.exe";
        ssh-add = "ssh-add.exe";
      };
      git = {
        extraConfig = {
          core.sshCommand = "ssh.exe";
        };
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  security.sudo.wheelNeedsPassword = false;

  services.vscode-server = {
    enable = true;
    # Disable signature verification to fix extension installation on NixOS
    # NixOS patches the VS Code server binary, which breaks Microsoft's signatures
    enableFHS = true;
  };

  # Set environment variable globally for all users
  environment.sessionVariables = {
    VSCODE_SKIP_SIGNATURE_VERIFICATION = "1";
  };

  time.timeZone = "Europe/Berlin";
  zramSwap.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
