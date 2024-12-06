{ config, pkgs, lib, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type file --type directory --strip-cwd-prefix --hidden --follow --exclude .git";
    fileWidgetCommand = config.programs.fzf.defaultCommand;
  };
}
