{
  pkgs,
  osConfig,
  ...
}:
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
        gdu
        genact
        go
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
        yq-go
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
