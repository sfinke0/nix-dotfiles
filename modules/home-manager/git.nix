{
  vars,
  osConfig,
  ...
}: {
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
      };
      inherit (vars) userEmail;
    };
  };
}
