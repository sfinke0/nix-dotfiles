{
  vars,
  osConfig,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = vars.fullName;
      extraConfig = {
        core = {
          editor = "vim";
        };

        pull = {
          rebase = true;
        };

        push = {
          autoSetupRemote = true;
        };

        # Conditional config based on directory
        includeIf."gitdir:~/repos/cxt/" = {
          path = "~/.gitconfig-cxt";
        };
        includeIf."gitdir:~/work/" = {
          path = "~/.gitconfig-work";
        };
      };
      inherit (vars) userEmail;
    };
  };

  # Create conditional config files
  home.file.".gitconfig-cxt".text = ''
    [user]
      email = carazzimo@convention-x-treme.de
      name = ${vars.fullName}
  '';

  home.file.".gitconfig-work".text = ''
    [user]
      email = ${vars.userEmail}
      name = ${vars.fullName}
  '';
}
