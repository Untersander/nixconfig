
{ config, ... }:
{
  home.file.yazi = {
    enable = true;
    target = "./.config/yazi/yazi.toml";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/yazi/yazi.toml";
  };
}