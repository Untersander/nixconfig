{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";

    shellAliases = {
      switch = "darwin-rebuild switch --flake ~/nixconfig";
      check = "darwin-rebuild check --flake ~/nixconfig";
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
    };
    history = {
      ignoreSpace = true;
      ignoreAllDups = true;
    };
    profileExtra = ''
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"
      # Zinit
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      # Download zinit if necessary
      if [[ ! -d $ZINIT_HOME ]]; then
        mkdir -p "$(dirname $ZINIT_HOME)"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      fi
    '';
    # initExtraFirst = '''';
    initExtraBeforeCompInit = ''
      source "$ZINIT_HOME/zinit.zsh"
      zinit ice depth=1; zinit light romkatv/powerlevel10k
      # Add in zsh plugins
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-autosuggestions
      zinit light Aloxaf/fzf-tab
    '';
    initExtra = ''
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
      kubeconfig=' '
      for kconfig in ''$HOME/.kube ''$(find ''$HOME/.kube -iname "*.config")
      do
        if [ -f "''$kconfig" ];then
          kubeconfig=$kubeconfig:''$kconfig
        fi
      done
      export KUBECONFIG=''$kubeconfig
      kubectl config view --flatten > ''$HOME/.kube/config
      export PATH="''${KREW_ROOT:-''$HOME/.krew}/bin:''$PATH"
      # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
      [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
    '';
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
    enableAliases = true;
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
