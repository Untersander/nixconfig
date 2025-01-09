{ config, ... }: {
  home.file.aerospace = {
    enable = true;
    target = "./.config/aerospace/aerospace.toml";
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/aerospace/aerospace.toml";
  };
}
