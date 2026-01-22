{
  pkgs,
  unstable ? null,
  osConfig,
  ...
}:
let
  unstablePkgs = if unstable != null then unstable.legacyPackages.${pkgs.system} else pkgs;
in
{
  home = {
    packages =
      with pkgs;
      [
        ansible
        curl
        dig
        du-dust
        dua
        duf
        gcc
        gdu
        genact
        imagemagick
        inetutils
        jq
        mr
        nixfmt-rfc-style
        openssl
        pietrasanta-traceroute
        poppler_utils
        pre-commit
        qrencode
        tree
        wget
        wireguard-tools
        yq-go

        # typst
        unstablePkgs.typst
        roboto
        font-awesome
        source-sans-pro

        unstablePkgs.go
        unstablePkgs.gopls
        unstablePkgs.golangci-lint
        unstablePkgs.gotools

        unstablePkgs.python313
        unstablePkgs.poetry
      ]
      ++ (
        if builtins.substring 0 3 osConfig.networking.hostName != "svr" then
          [
            # Below packages are for personal machines only; excluded from servers
            # inspo: https://discourse.nixos.org/t/how-to-use-hostname-in-a-path/42612/3
            alejandra
            nixos-rebuild # need for macOS
            sops
          ]
        else
          [
            # Below packages are for servers only; excluded from personal machines
          ]
      );
  };
}
