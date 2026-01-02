{ lib, config, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    dotDir = config.xdg.configHome + "/zsh";
    defaultKeymap = "viins";

    shellAliases = {
      switch = "sudo -H nix run nix-darwin -- switch --flake ~/nixconfig";
      check = "sudo -H nix run darwin-rebuild check --flake ~/nixconfig";
      clab = "docker run --rm -it --privileged --network=host -v /var/run/docker.sock:/var/run/docker.sock -v /var/run/netns:/var/run/netns -v /etc/hosts:/etc/hosts -v /var/lib/docker/containers:/var/lib/docker/containers --pid=host -v $(pwd):$(pwd) -w $(pwd) ghcr.io/srl-labs/clab /usr/bin/containerlab";
      nixbuild = "darwin-rebuild build --flake ~/nixconfig";
      nixupdate = "nix flake update --flake ~/nixconfig";
      nixdiff = "cd ~/nixconfig && nixbuild && nix store diff-closures /var/run/current-system ./result";
      nixudiff = "cd ~/nixconfig && nixupdate && nixbuild && nix store diff-closures /var/run/current-system ./result";
      nvdiff = "cd ~/nixconfig && nixbuild && nvd diff /var/run/current-system ./result";
      nvudiff = "cd ~/nixconfig && nixupdate && nixbuild && nvd diff /var/run/current-system ./result";
      gas = "git add . & switch";
      sz = "source ~/.config/zsh/.zshrc";
      k = "kubectl";
      k8s-show-ns = " kubectl api-resources --verbs=list --namespaced -o name  | xargs -n 1 kubectl get --show-kind --ignore-not-found  -n";
      t = "talosctl";
      iterm = "open -a iTerm $*";
      nv = "nvim";
      optf = "op run --env-file tf.env -- terraform";
      opto = "op run --env-file tf.env -- tofu";
      opt = "op run --env-file tf.env -- terragrunt";
      activate = "source .venv/bin/activate";
      python = "python3";
      py = "python3";
      r = "fc -e -";
      resticsource = "source ~/nixconfig/applications/restic/restic.env";
    };
    history = {
      ignoreSpace = true;
      ignoreAllDups = true;
    };
    # .zshenv
    # envExtra = '''';
    # .zprofile
    profileExtra = ''
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"
      # Zinit
      export ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      # Download zinit if necessary
      if [[ ! -d $ZINIT_HOME ]]; then
        mkdir -p "$(dirname $ZINIT_HOME)"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      fi
      # UV tools (python tools)
      export PATH="''$PATH:''$HOME/.local/bin"
      # Rust tools
      export PATH="''$PATH:''$HOME/.cargo/bin"
      # Expand alias
      # globalias() {
      #   zle _expand_alias
      #   zle expand-word
      #   zle self-insert
      # }
      # zle -N globalias
      # # space expands all aliases
      # bindkey -M viins " " _expand_alias
      # # control-space to make a normal space
      # bindkey -M viins "^ " magic-space
      # # normal space during searches
      # bindkey -M isearch " " magic-space
      # Useful keybinds for vimode
      bindkey '^r' history-incremental-search-backward
      bindkey '^a' beginning-of-line
      bindkey '^e' end-of-line
      bindkey '^[b' vi-backward-blank-word
      bindkey '^[w' vi-forward-blank-word
      bindkey -M viins '^f' vi-forward-word
      # Also fix annoying vi backspace
      bindkey '^?' backward-delete-char
    '';
    # .zshrc
    # initExtraFirst = '''';
    initContent =
      let
        initExtraBeforeCompInit = lib.mkOrder 550 ''
          source "$ZINIT_HOME/zinit.zsh"
          zinit ice depth=1; zinit light romkatv/powerlevel10k
          # Add in zsh plugins
          zinit light zsh-users/zsh-syntax-highlighting
          zinit light zsh-users/zsh-completions
          zinit light zsh-users/zsh-autosuggestions
          zinit light Aloxaf/fzf-tab
        '';
        zshConfig = lib.mkOrder 1000 ''
          zinit cdreplay -q
          # Add in snippets
          zinit snippet OMZP::git
          zinit snippet OMZP::sudo
          zinit snippet OMZP::kubectl
          zinit snippet OMZP::kubectx
          zinit snippet OMZP::terraform
          # Completion styling
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
          zstyle ':completion:*' menu no
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
          # Shell integrations
          eval "$(fzf --zsh)"
          eval "$(zoxide init --cmd cd zsh)"
          # Kubernetes
          unset kubeconfig
          for kconfig in $HOME/.kube $(find $HOME/.kube -iname "*.config")
          do
            if [ -f "$kconfig" ];then
              kubeconfig=$kconfig:$kubeconfig
            fi
          done
          cp $HOME/.kube/config $HOME/.kube/config.bak
          export KUBECONFIG=$kubeconfig$HOME/.kube/config.bak
          kubectl config view --flatten > $HOME/.kube/config
          export KUBECONFIG=$HOME/.kube/config
          export PATH="''${KREW_ROOT:-''$HOME/.krew}/bin:''$PATH"
          # Golang
          export PATH="''$PATH:''$GOBIN"
          # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
          [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
        '';
      in
      lib.mkMerge [
        initExtraBeforeCompInit
        zshConfig
      ];
  };
  home.file.kube = {
    enable = true;
    target = "./.kube/.gitkeep";
    text = "Create empty .kube folder";
  };
  home.file.p10k = {
    enable = true;
    target = "./.config/zsh/.p10k.zsh";
    source = ./.p10k.zsh;
  };
  programs.bat.enable = true;
  programs.jq.enable = true;
  programs.lsd = {
    enable = true;
  };
  programs.pandoc.enable = true;
  programs.zoxide.enable = true;
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      style = "compact";
      show_help = false;
      inline_height = 20;
      keymap_mode = "vim-insert";
    };
  };
}
