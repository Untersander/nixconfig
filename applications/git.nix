{ pkgs, ... }:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcS2Q2ECuF0eu+GdsULBu6uwfRrVyoIQNN5AarCNOQ/";
in
{
  programs.git = {
    enable = true;
    userEmail = "jan.untersander@ost.ch";
    userName = "Jan Untersander";

    lfs.enable = true;

    ignores =
      [
        # IDEs
        ".vscode"
        ".vsc"
        ".vs"
        ".idea"
        # Python
        "*.pyc"
        "*.pyo"
        "__pycache__"
        # Node
        "node_modules"
        "npm-debug.log"
      ]
      ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
        # MacOS
        ## General
        ".DS_Store"
        ".AppleDouble"
        ".LSOverride"
        ## Icon must end with two \r
        "Icon"
        ## Thumbnails
        "._"
        ## Files that might appear in the root of a volume
        ".DocumentRevisions-V100"
        ".fseventsd"
        ".Spotlight-V100"
        ".TemporaryItems"
        ".Trashes"
        ".VolumeIcon.icns"
        ".com.apple.timemachine.donotpresent"
        ## Directories potentially created on remote AFP share
        ".AppleDB.AppleDesktop"
        "Network"
        "Trash"
        "Folder"
        "Temporary"
        "Items.apdisk"
      ];

    aliases = {
      rv = "remote -v";
      c = "commit";
      cm = "commit -m";
      ca = "commit -am";
      s = "status -sb";
      cleangone = "!git fetch --all --prune; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D;";
      cleanmerged = "!git branch -d `git branch --merged | egrep -v '^(\\*|main|master)'`";
      # quick-stats = "! /usr/local/bin/git-quick-stats";
      # fame = "python3.exe -m gitfame";
    };

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push.autoSetupRemote = true;
      pull.rebase = true;
      fetch.pruen = true;
      help.autocorrect = 30;
      commit.gpgsign = true;
      user.signingkey = publicKey;
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = builtins.toFile "allowed_signers" ''
          jan.untersander@ost.ch ${publicKey}
        '';
      };
    };
  };
}

#   extraConfig = {
# init.defaultBranch = "main";
# push.default = "current";
# rerere.enabled = true;
# status.short = true;
# commit.verbose = true;

# rebase = {
# abbreviateCommands = true;
# autostash = true;
# autosquash = true;
# updateRefs = true;
# };
# commit.gpgsign = true;
# user.signingkey = publicKey;

# "gpg \"ssh\"".program =
# if pkgs.stdenv.isDarwin then
# "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
# else
# "${pkgs._1password-gui}/bin/op-ssh-sign";

# gpg = {
# format = "ssh";
# ssh.allowedSignersFile = builtins.toFile "allowed_signers" ''
#           dev@jeremystucki.ch ${publicKey}
#           jeremy.stucki@valora.com ${publicKey}
#           jeremy.stucki@ost.ch ${publicKey}
#         '';
# };
# };
#   delta = {
#       enable = true;
#       options = {
#         navigate = true;
#         side-by-side = true;
#         file-style = "bold yellow ul";
#       };
#     };

#     includes = [
#       {
#         condition = "hasconfig:remote.*.url:git@github.com:*/**";
#         contents = {
#           user.email = "dev@jeremystucki.ch";
#         };
#       }
#       {
#         condition = "hasconfig:remote.*.url:git@github.com:valora-digital/**";
#         contents = {
#           user.email = "jeremy.stucki@valora.com";
#         };
#       }
#       {
#         condition = "hasconfig:remote.*.url:https://git.sonova.com/*/**";
#         contents = {
#           user.email = "jeremy.stucki.external@sonova.com";
#         };
#       }
#       {
#         condition = "hasconfig:remote.*.url:ssh://git@gitlab.ost.ch:*/**";
#         contents = {
#           user.email = "jeremy.stucki@ost.ch";
#         };
#       }
#     ];
#   };
# }
