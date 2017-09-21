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

ask "Update base system?" Y && {
	sudo apt update
	sudo apt upgrade
}

ask "Install essential packages?" Y && {
	sudo apt install \
	git \
	vim \
	lm-sensors \
	htop glances \
	ranger
}

ask "Install GUI components?" Y && {
	sudo add-apt-repository ppa:aguignard/ppa
	sudo apt update
	sudo apt install \
	kdm \
	libxcb-xrm-dev \
	libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev 

	echo "Installing i3-gaps"

	# clone the repository
	git clone https://www.github.com/Airblader/i3 i3-gaps
	cd i3-gaps

	# compile & install
	autoreconf --force --install
	rm -rf build/
	mkdir -p build && cd build/

	../configure --prefix=/usr --sysconfdir=/etc
	make
	sudo make install
	
}
