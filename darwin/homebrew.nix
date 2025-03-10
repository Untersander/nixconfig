{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    onActivation.cleanup = "zap";
    masApps = {
      "Windows App" = 1295203466;
      "Yubico Authenticator" = 1497506650;
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
      # "alt-tab"
      # "balenaetcher"
      "blender"
      "devpod"
      "discord"
      "drawio"
      "firefox"
      "hoppscotch"
      "iina"
      # "jetbrains-toolbox"
      "keycastr"
      # "logitech-presentation"
      "losslesscut"
      "mactex"
      "mac-mouse-fix"
      "microsoft-auto-update"
      "microsoft-teams"
      "microsoft-word"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-outlook"
      "onedrive"
      "obs"
      "obsidian"
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
      # "thunderbird"
      "typora"
      "ukelele"
      # "visual-studio"
      "visual-studio-code"
      "vmware-fusion"
      # "wireshark"
      "whatsapp"
      "zed"
      "zen-browser"
    ];
    taps = [
      "nikitabobko/tap"
      "argoproj/tap"
      "anchore/grype"
      "dagger/tap"
      "go-task/tap"
      "goreleaser/tap"
      "powershell/tap"
      "hashicorp/tap"
      "siderolabs/tap"
    ];
    brews = [
      "mas"
      "grype"
      # "apktool"
      # "jadx"
      "argocd"
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
      "k9s"
      "krew"
      "ko"
      "kompose"
      "kubent"
      "mtr"
      # "pnpm"
      "protobuf"
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
      # "termshark"
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
      "yarn"
      "yq"
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
