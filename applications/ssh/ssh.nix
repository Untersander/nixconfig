{ config, ... }:
{
  home.file.ssh = {
    enable = true;
    target = "./.ssh/config";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/ssh/config";
  };
}
