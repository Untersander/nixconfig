{ pkgs, config, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_25;
    env = {
      GOPATH = config.xdg.configHome + "/go";
      GOBIN = config.xdg.configHome + "/go/bin";
    };
  };
}
