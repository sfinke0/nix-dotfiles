{
  lib,
  pkgs,
  vars,
  osConfig,
  ...
}:
{
  imports = [
    ./_packages.nix
    ./_zsh.nix
  ];

  home = {
    username = vars.userName;
    homeDirectory = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${vars.userName}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${vars.userName}")
    ];
    stateVersion = "23.11";
    sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
      SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
    };
  };

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = ["--reverse"];
    };
    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
    htop.enable = true;
    lsd.enable = true;
    git.enable = true;
    nh.enable = true;
    vim.enable = true;
    yt-dlp.enable = true;
    lazygit.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
  };

  # Nicely reload system units when changing configs
  # Self-note: nix-darwin seems to luckily ignore this setting
  systemd.user.startServices = "sd-switch";
}
