{
  inputs,
  outputs,
  vars,
  unstable,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.default
    inputs.vscode-server.nixosModules.default

    ./hardware-configuration.nix

    ./../../modules/wsl/base.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars unstable; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${vars.userName} = {
        imports = [
          ./../../modules/home-manager/base.nix
          ./../../modules/home-manager/git.nix
        ];
      };
    };
  };

  networking.hostName = "dwbid-wsl";
}
