{ config, pkgs, lib, ... }:
{
  programs.go = {
      enable = true;
      package = pkgs.go_1_23;
      goPath = "${config.home.homeDirectory}/go";
      goBin = "${config.home.homeDirectory}/go/bin";
  };
}
