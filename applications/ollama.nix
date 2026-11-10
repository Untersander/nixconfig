{ config, pkgs-unstable, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama;
    host = "127.0.0.1";
    port = 11434;
  };
  launchd.agents.ollama.config = {
    StandardOutPath = "${config.home.homeDirectory}/Library/Logs/ollama.out.log";
    StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/ollama.err.log";
  };
}
