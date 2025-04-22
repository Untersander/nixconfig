{ pkgs, ... }:
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
    /aws/aws.nix
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
      # Command Line
      neofetch
      neovim
      git
      tmux
      wget
      bat
      htop
      btop
      gdu
      watch
      viddy # alternate watch command
      age # encryption tool
      atac # postman like cli tool
      comma # nix-shell wrapper
      # wireshark
      nvd
      thefuck # auto correct commands
      # Nix
      nil
      nixfmt-rfc-style
      # Desktop apps
      # vscode
      # obsidian
      # mpv
      # Tex
      texliveFull
      # Devops
      gh
      devbox
      niv
      # ansible
      # sshpass # required for ansible
      # K8s
      kubectl
      krew
      kustomize
      kubernetes-helm
      stern
      kind
      operator-sdk
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
