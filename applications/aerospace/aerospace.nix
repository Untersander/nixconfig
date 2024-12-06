{ ... }: {
  home.file.aerospace = {
    enable = true;
    target = "./.config/aerospace/aerospace.toml";
    source = ./aerospace.toml;
  };
}
