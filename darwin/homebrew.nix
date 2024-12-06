{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    onActivation.cleanup = "zap";
    masApps = {
    };
    casks = [
      "1password"
      "1password-cli"
      "brave-browser"
      "raycast"
      # "ukelele"
      "orbstack"
      "nikitabobko/tap/aerospace"
      # "4k-video-downloader"
      # "adobe-acrobat-reader"
      "alt-tab"
      "balenaetcher"
      "blender"
      "discord"
      "drawio"
      "firefox"
      "hoppscotch"
      "iina"
      # "jetbrains-toolbox"
      "keycastr"
      # "logitech-presentation"
      "mactex"
      "microsoft-auto-update"
      "microsoft-teams"
      "microsoft-word"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-outlook"
      "onedrive"
      "obs"
      # "ollama"
      # "plex"
      # "qflipper"
      "qlmarkdown"
      "signal"
      "slack"
      "syntax-highlight"
      "telegram-desktop"
      # "the-unarchiver"
      "threema"
      "thunderbird"
      "typora"
      # "visual-studio"
      # "visual-studio-code"
      "vlc"
      # "wireshark"
      "whatsapp"
      "zed"
      "zen-browser"
    ];
    taps = [
      "nikitabobko/tap"
      "argoproj/tap"
      "dagger/tap"
      "go-task/tap"
      "goreleaser/tap"
      "powershell/tap"
      "hashicorp/tap"
      "siderolabs/tap"
    ];
    brews = [
      "mas"
      # "apktool"
      # "jadx"
      "argocd"
      "atuin"
      "blueutil"
      "broot"
      "btop"
      "cilium-cli"
      "clusterctl"
      # "cmatrix"
      "crane"
      "difftastic"
      "dive"
      "dua-cli"
      "entr"
      "fclones"
      "fd"
      # "tesseract"
      "ffmpeg"
      "gdu"
      "gitleaks"
      "gnmic"
      "graphviz"
      "hadolint"
      "htop"
      "imagemagick"
      # "iodine"
      "iproute2mac"
      "istioctl"
      "jq"
      "k9s"
      "ko"
      "kompose"
      "kubent"
      "lsd"
      "mtr"
      "ncdu"
      "nmap"
      "nnn"
      "node"
      "opentofu"
      "pandoc"
      "rdfind"
      "ripgrep"
      "ripgrep-all"
      # "rust"
      "sevenzip"
      "superfile"
      "syft"
      "telnet"
      "termshark"
      "terraform"
      "terraform-docs"
      "terragrunt"
      "tfmigrate"
      "tio"
      "tldr"
      "tree"
      "trivy"
      "typst"
      "uv"
      "yq"
      "zoxide"
      "argoproj/tap/kubectl-argo-rollouts"
      "dagger/tap/dagger"
      "go-task/tap/go-task"
      "goreleaser/tap/goreleaser"
      "hashicorp/tap/packer"
      "powershell/tap/powershell"
      "siderolabs/tap/talosctl"
    ];
  };
}