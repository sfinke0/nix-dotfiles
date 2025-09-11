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
      inherit (vars) userEmail;
    };
  };
}
