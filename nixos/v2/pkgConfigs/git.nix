{ ... }:

{
  programs.git = {
    enable = true;
    userName = "faeblDevelopment";
    userEmail = "faebl.taylor@pm.me";
    extraConfig.core.editor = "vim";
  };
}
