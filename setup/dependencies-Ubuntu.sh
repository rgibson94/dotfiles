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

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
    # set to 1 initially
    local return_=1
    # set to 0 if not found
    type $1 >/dev/null 2>&1 || { local return_=0;  }
    # return value
    echo "$return_"

}

# display a message in red with a cross by it
# example
# echo echo_fail "No"
function echo_fail {
    # echo first argument in red
    printf "\e[31m✘ ${1}"
    # reset colours back to normal
    printf "\033[0m"
}

# display a message in green with a tick by it
# example
# echo echo_fail "Yes"
function echo_pass {
    # echo first argument in green
    printf "\e[32m✔ ${1}"      
    # reset colours back to normal
    printf "\033[0m"
}

# echo pass or fail
# example
# echo echo_if 1 "Passed"
# echo echo_if 0 "Failed"
function echo_if {
    if [ $1 == 1  ]; then
        echo_pass $2
    else
        echo_fail $2
    fi

}

echo "node          $(echo_if $(program_is_installed node))"

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
	ranger \
    vim-nox \
    build-essential openssl libreadline6 libreadline6-dev \
    curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev \
    sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake \
    libtool bison subversion nodejs \
    gnupg2

}

ask "Install GUI components?" Y && {
	sudo add-apt-repository ppa:aguignard/ppa
    sudo add-apt-repository ppa:nathan-renniewaldock/flux
	sudo apt update
	sudo apt install \
	lightdm \
	libxcb-xrm-dev \
	libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev \
    libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev \
    libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev \
    libxkbcommon-x11-dev autoconf libxcb-xrm-dev \
    i3lock \
    pulseaudio-ctl pavucontrol \
    network-manager-applet networkmanager-openvpn \
    firefox \
    thunar thunar-archive-plugin \
    fluxgui
    

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
