{ config, pkgs, ... }:
let
  imports = map (x: ../applications + x) [
    /git.nix
    /zsh.nix
    /fzf.nix
    /aerospace/aerospace.nix
    /raycast/raycast.nix
    /ssh/ssh.nix
    /go.nix
    /ollama.nix
  ];

in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  inherit imports;

  xdg.enable = true;
  home = {
    username = "jan";
    homeDirectory = "/Users/jan";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = "en_US.UTF-8";
    };
    packages = with pkgs; [
      neofetch
      neovim
      git
      tmux
      wget
      nixfmt-rfc-style
      vscode
      obsidian
      bat
      htop
      btop
      gdu
      nvd
      nil
      sshpass # required for ansible
      comma # nix-shell wrapper
      thefuck # auto correct commands
      watch
      viddy # alternate watch command
      age # encryption tool
      atac # postman like cli tool
      wireshark
      mpv # Currently not launchable from raycast/finder
      texlive.combined.scheme-full
      # Devops
      operator-sdk
      devbox
      kubectl
      krew
      kubernetes-helm
      kustomize
      kind
      ansible
    ];
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    nix-index = {
      # comma dependency
      enable = true;
      enableZshIntegration = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}
