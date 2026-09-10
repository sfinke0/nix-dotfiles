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
      settings = {
        core = {
          editor = "vim";
        };

        pull = {
          rebase = true;
        };

        push = {
          autoSetupRemote = true;
        };

      };
      includes = [
        {
          condition = "gitdir:~/repos/cxt/";
          path = "~/.gitconfig-cxt";
        }
        {
          condition = "gitdir:~/repos/work/";
          path = "~/.gitconfig-work";
        }
        {
          condition = "gitdir:~/repos/private/";
          path = "~/.gitconfig-private";
        }
      ];
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

  home.file.".gitconfig-private".text = ''
    [user]
      email = s@fn.ke
      name = ${vars.fullName}
  '';
}
