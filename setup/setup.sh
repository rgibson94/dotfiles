#!/bin/bash
set -e

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

dir=`pwd`
if [ ! -e "${dir}/$(basename $0)" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

ask "Echo pwd" Y  && echo ${dir}

distro=`lsb_release -si`

echo $distro
if [ ! -f "dependencies-${distro}.sh" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  exit 2
fi

ask "Install packages?" Y && bash ./dependencies-${distro}.sh
