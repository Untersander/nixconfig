{ config, ... }:
{
  home.file.awscredentials = {
    enable = true;
    target = "./.aws/credentials";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/aws/credentials";
  };
  home.file.awsconfig = {
    enable = true;
    target = "./.aws/config";
    # Out of store symlink to the actual file in ~/nixconfig to remove the need to rebuild the system
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/applications/aws/config";
  };
}
