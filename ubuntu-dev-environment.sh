#!/bin/bash
# function to clear screen and print a message before next step
clear_and_print()
{
  clear
  echo $1
}

#making useful directories
clear_and_print 'creating folders'
mkdir ~/PWAs
mkdir ~/Projetos
mkdir ~/ISOs

clear_and_print 'removing lockers'
# removing locks from SO
sudo rm /var/lib/dpkg/lock-frontend; sudo rm /var/cache/apt/archives/lock ;
sudo dpkg --add-architecture i386
sudo dpkg --configure -a

#setting greeter monitor infos
sudo cp ~/.config/monitors.xml ~gdm/.config/

# first lets update everything
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoclean -y && sudo apt-get autoremove -y

# adding repositories
sudo apt-add-repository ppa:graphics-drivers/ppa -y

#first let's install some stuff to make another stuff work or to controll system
sudo apt-get update && sudo apt install curl -y && sudo apt-get install git zsh vim htop filezilla mc -y
sudo apt-get install ttf-mscorefonts-installer ubuntu-restricted-extras libavcodec-extra libav-tools -y

#python
sudo apt-get install python3.9 pip3 python3-mysql.connector -y

# then the IDE, browser and stuffs ---------------------------------------------
# VSCODE
wget https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -O /tmp/code_latest_amd64.deb
# github desktop
wget https://github.com/shiftkey/desktop/releases/download/release-2.4.1-linux1/GitHubDesktop-linux-2.4.1-linux1.deb -O /tmp/github_desktop.deb
# google chrome
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google_chrome.deb
# zoom
wget -c https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom.deb
# create-react-app
sudo npm i -g create-react-app

wget https://downloads.mongodb.com/compass/mongodb-compass_1.30.1_amd64.deb -O /tmp/mongodb-compass.deb

# now installing .deb stuff ----------------------------------------------------
clear_and_print 'now installing .deb stuff'
sudo chmod 775 /tmp/*.deb
sudo dpkg -i /tmp/*.deb || sudo apt-get --fix-broken install -y && sudo dpkg -i /tmp/*.deb


# Nativifier (to create PWAs)
sudo npm i -g nativefier

# gimp
sudo apt-get update
sudo apt-get install gimp -y


# font cascadia
sudo wget https://github.com/microsoft/cascadia-code/releases/download/v1911.21/Cascadia.ttf -O /usr/share/fonts/truetype/Cascadia.ttf
sudo wget https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaMono.ttf -O /usr/share/fonts/truetype/CascadiaMono.ttf
sudo wget https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaMonoPL.ttf -O /usr/share/fonts/truetype/CascadiaMonoPL.ttf

# font menlo for terminal fix
sudo wget https://github.com/abertsch/Menlo-for-Powerline/blob/master/Menlo%20for%20Powerline.ttf -O /usr/share/fonts/truetype/Menlo\ for\ Powerline.ttf

# Wine
sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

# then the languages/compilers -------------------------------------------------
clear_and_print 'installing dev stuff'
# php
sudo apt-get install apache2 php7.2 php-mysql php-xdebug -y

sudo apt-get install tmux -y


# mysql
sudo apt-get install mysql-server-5.7 mysql-client-5.7 mysql-workbench mysql-workbench-data -y

# installing docker
clear_and_print 'installing docker'
sudo apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
# docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "Docker and docker compose successfully installed"
docker --version
docker-compose --version

# nodejs 12.16.2
clear_and_print 'installing nvm'

#nvm install
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

#-------------------------------------------------------------------------------
# finishing  -------------------------------------------------------------------
clear_and_print 'Finishing with another update and then autoclean autoremove'
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoclean -y && sudo apt-get autoremove -y

# lets install
clear_and_print 'Lets install zsh with configurated theme\nPay attention, you will need to insert your password here...'
sudo apt-get install fonts-powerline -y
sudo apt-get install zsh -y

wget -qO- https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting



#--------------------
clear_and_print 'Installing logitech config'

sudo apt install cmake libevdev-dev libudev-dev libconfig++-dev -y
git clone https://github.com/PixlOne/logiops.git
cd logiops/
mkdir build
cd build/
cmake ..
make
sudo make install
sudo cp ../../logid.cfg /etc/logid.cfg
sudo systemctl enable --now logid

#-----------------

#--------------------
clear_and_print 'Install unity hub'

sudo sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
wget -qO - https://hub.unity3d.com/linux/keys/public | sudo apt-key add -
sudo apt update
sudo apt-get install unityhub
sudo apt-get remove unityhub

#-----------------

#--------------------
clear_and_print 'Install snaps'

sudo snap install postman
sudo snap install webstorm
sudo snap install datagrip

#-----------------


chsh -s /usr/bin/zsh
