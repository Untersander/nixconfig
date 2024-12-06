{ ... }: {
  home.file.ssh = {
    enable = true;
    target = "./.ssh/config";
    source = ./config;
  };
}