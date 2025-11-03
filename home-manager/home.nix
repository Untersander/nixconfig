{ pkgs, pkgs-unstable, ... }:
let
  imports = map (x: ../applications + x) [
    /git.nix
    /zsh.nix
    /fzf.nix
    /aerospace/aerospace.nix
    /raycast/raycast.nix
    /ssh/ssh.nix
    /go.nix
    # /ollama.nix
    /aws/aws.nix
    /restic/restic.nix
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
      PAGER = "bat -p";
      VISUAL = "nvim";
      LANG = "en_US.UTF-8";
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
    packages = with pkgs; [
      # Command Line
      age # encryption tool
      atac # postman like cli tool
      bat
      btop
      comma # nix-shell wrapper
      gdu
      git
      htop
      neofetch
      neovim
      nvd
      pkgs-unstable.restic
      pkgs-unstable.resticprofile
      sshpass
      tmux
      viddy # alternate watch command
      watch
      wget
      yazi
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
      devbox
      gh
      niv
      # K8s
      pkgs-unstable.kind
      pkgs-unstable.krew
      pkgs-unstable.kubectl
      pkgs-unstable.kubernetes-helm
      pkgs-unstable.kustomize
      pkgs-unstable.operator-sdk
      pkgs-unstable.stern
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
