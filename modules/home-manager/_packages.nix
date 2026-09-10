{
  pkgs,
  inputs,
  unstable ? null,
  osConfig,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  unstablePkgs = if unstable != null then unstable.legacyPackages.${system} else pkgs;
in
{
  home = {
    packages =
      with pkgs;
      [
        ansible
        python313Packages.mitogen
        python313Packages.uv
        age
        curl
        dig
        dust
        dua
        duf
        git-filter-repo
        unstablePkgs.glab
        gcc
        gdu
        genact
        imagemagick
        inetutils
        jq
        kanidm_1_9
        libcap
        libwebp
        mr
        nixfmt
        openssl
        pietrasanta-traceroute
        poppler-utils
        pre-commit
        qrencode
        tree
        wget
        wireguard-tools
        yq-go
        zip
        _7zz

        # typst
        unstablePkgs.typst
        roboto
        font-awesome
        source-sans-pro

        unstablePkgs.go
        unstablePkgs.gopls
        unstablePkgs.golangci-lint
        unstablePkgs.gotools

        unstablePkgs.python314

        inputs.llm-agents.packages.${system}.codex
        inputs.llm-agents.packages.${system}.codex-acp
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
