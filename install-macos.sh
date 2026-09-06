#!/usr/bin/env sh

# shellcheck disable=SC2039

# Options
#
# -h: Print help
# -i: Install Nix dependencies (Homebrew, Nix)
# -r: Restore Nix configuration
# -y: Yes to all prompts (non-interactive)

set -eu
printf '\n'

YES=0

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

help() {
   echo "Script to install and restore my nix configuration on macos"
   echo
   echo "Options:"
   echo "  -h  Print help"
   echo "  -i  Install Nix dependencies (Homebrew, Nix)"
   echo "  -r  Restore Nix configuration"
   echo "  -y  Yes to all prompts (non-interactive)"
   echo
}

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
  printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

confirm() {
  if [ "$YES" -eq 1 ]; then
    return 0
  fi
  printf "%s " "${MAGENTA}?${NO_COLOR} $* ${BOLD}[y/N]${NO_COLOR}"
  set +e
  read -r yn </dev/tty
  rc=$?
  set -e
  if [ $rc -ne 0 ]; then
    error "Error reading from prompt (please re-run with the '-y' option)"
    exit 1
  fi
  if [ "$yn" != "y" ] && [ "$yn" != "yes" ]; then
    error 'Aborting (please answer "yes" to continue)'
    exit 1
  fi
}

install_homebrew() {
    info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    completed "Homebrew installed"
}


install_nix() {
    info "Installing Nix"
    curl -sSf -L https://install.lix.systems/lix | sh -s -- install
    completed "Nix installed"

}

installation() {
    confirm "Do you want to install Nix?"
    install_nix
    confirm "Do you want to install homebrew?"
    install_homebrew
}

restore_nix_configuration() {
    confirm "Do you want to restore Nix configuration?"
    info "Restoring Nix configuration"
    sudo -H nix run nix-darwin -- switch --flake ~/nixconfig
    completed "Nix configuration restored"
    post_restore
}

post_restore() {
    info "Post restore"
    sudo wget --directory-prefix /Library/Keyboard\ Layouts https://raw.githubusercontent.com/Untersander/macos-us-altgr-intl/refs/heads/master/personal-us-intl-altgr-deadkeys.keylayout
    info "Applied US-intl-altgr Layout Reboot to activate"
    completed "Post restore completed"

}


for arg in "$@"; do
  if [ "$arg" = "--yes" ]; then
    YES=1
  fi
done

while getopts "hiyr" option; do
  case $option in
    h)
      help
      exit;;
    i)
      installation
      ;;
    r)
      restore_nix_configuration
      ;;
    y)
      YES=1
      ;;
    ?)
      error "Invalid option: -$OPTARG"
      exit;;
  esac
done

help
