{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_25;
    env = {
      GOPATH = "/go";
      GOBIN = "/go/bin";
    };
  };
}
