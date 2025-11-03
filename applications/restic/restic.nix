{ config, ... }:
{
  home.file.resticprofile = {
    enable = true;
    target = ".config/resticprofile/profiles.yaml";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/restic/resticprofile.yaml";
  };
}
