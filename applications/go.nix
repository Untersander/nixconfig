{ config, pkgs, lib, ... }:
{
  programs.go = {
      enable = true;
      package = pkgs.go_1_23;
  };
}
