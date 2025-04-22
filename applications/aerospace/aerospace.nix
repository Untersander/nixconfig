{ config, ... }:
{
  home.file.aerospace = {
    enable = true;
    target = "./.config/aerospace/aerospace.toml";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/aerospace/aerospace.toml";
  };
}
