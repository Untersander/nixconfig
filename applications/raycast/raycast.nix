{ ... }: {
  home.file.raycast = {
    enable = true;
    target = "./.config/raycast/raycast.rayconfig";
    source = ./raycast.rayconfig;
  };
}