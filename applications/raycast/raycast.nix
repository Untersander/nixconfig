{ config, ... }: {
  home.file.raycast = {
    enable = true;
    target = "./.config/raycast/raycast.rayconfig";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/raycast/raycast.rayconfig";
  };
}