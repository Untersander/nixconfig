{ config, ... }:
{
  # Go itself is installed via homebrew
  home.sessionVariables = {
    GOPATH = config.xdg.configHome + "/go";
    GOBIN = config.xdg.configHome + "/go/bin";
  };
}
