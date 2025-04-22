{ config, pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;
    goPath = "${config.home.homeDirectory}/go";
    goBin = "${config.home.homeDirectory}/go/bin";
  };
}
