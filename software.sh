#!/bin/bash 
source `which virtualenvwrapper.sh`
echo "----------------------------------------------------------------------------"
echo "                        Software Setup Script"
echo "----------------------------------------------------------------------------"
#logging/utils/help
LOGGER=`pwd`/log_softwares.log
INFO="Software: INFO: "
ERROR="Software: ERROR: "
DEBUG="DEBUG: "
log()
{
	echo -e "[${USER}]\t[`date`]\t${*}" >> "${LOGGER}"
}
log $INFO "Begin"
if [ $Install_Flux -eq 1 ]; then
	sudo add-apt-repository -y ppa:nathan-renniewaldock/flux
fi
if [ $Install_Grive_GoogleDrive -eq 1 ]; then
	sudo add-apt-repository -y ppa:nilarimogard/webupd8
fi
if [ $Install_OracleJava8 -eq 1 ]; then
	#echo '' >> install_log.txt
	sudo add-apt-repository -y ppa:webupd8team/java
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections
fi
if [ $Install_QPDFView -eq 1 ]; then
	sudo add-apt-repository -y ppa:adamreichold/qpdfview-dailydeb
fi
if [ $Install_QBitTorrent -eq 1 ]; then
	sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
fi
if [ $Install_Atom -eq 1 ]; then
	sudo add-apt-repository -y ppa:webupd8team/atom
fi
## last is for grive - google drive client
##1
if [ $Install_SublimeText -eq 1 ]; then
	curl https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi
##2
if [ $Install_Vivaldi -eq 1 ]; then
	curl http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
	echo "deb http://repo.vivaldi.com/stable/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list
fi
##3
if [ $Install_VisualStudioCode -eq 1 ]; then
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
fi
##4
if [ $Install_GoogleChrome -eq 1 ]; then
	curl https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
fi

sudo sudo apt-key update && sudo apt-get update #>&/dev/null

#Zshell extension for bourne shell which is default = This allows for some better scripting
# Also adding intel-microcode
log $INFO "install zsh and intel microcode"

if [ $Install_ZSH -eq 1 ]; then
	log $INFO "install zsh"
	sudo apt-get install -y zsh
fi

if [ $Install_IntelFirmware -eq 1 ]; then
	log $INFO "install intel-microcode"
	sudo apt-get install -y intel-microcode
fi

# git and vcsh - vcsh allows you to manage multiple git repos in one directory
if [ $Install_Git -eq 1 ]; then
	log $INFO "install Git"
	sudo apt-get install -y vcsh git
fi

if [ $Install_Flux -eq 1 ]; then
	log $INFO "install Flux"
	sudo apt-get install -y fluxgui
fi

# password manager
if [ $Install_KeepassPasswordManager -eq 1 ]; then
	log $INFO "install keypass"
	sudo apt-get install -y keepassx
fi

# next 4web browsers options
if [ $Install_Chromium -eq 1 ]; then
	log $INFO "install chromium"
	sudo apt-get install -y chromium-browser
fi

if [ $Install_TexStudio -eq 1 ]; then
	log $INFO "install LaTeX"
	sudo apt-get install -y texlive-latex-base texlive-latex-extra texlive-science texlive-lang-english texstudio texlive-publishers
fi

if [ $Install_GoogleChrome -eq 1 ]; then
	log $INFO "install google chrome"
	sudo apt-get install -y google-chrome-stable
fi

if [ $Install_MozillaFirefox -eq 1 ]; then
	log $INFO "install firefox"
	sudo apt-get install -y firefox firefox-locale-en
fi

if [ $Install_Vivaldi -eq 1 ]; then
	log $INFO "install vivaldi"
	sudo apt-get install -y --install-recommends vivaldi-stable
fi
if [ $Install_GEdit -eq 1 ]; then
	log $INFO "install gedit"
	sudo apt-get install -y gedit
fi

# exfat
if [ $Install_EXFatUtils -eq 1 ]; then
	log $INFO "install exfat-utils"
	sudo apt-get install -y --install-recommends exfat-fuse exfat-utils	
fi

# vlc
if [ $Install_VLCMediaPlayer -eq 1 ]; then
	log $INFO "install vlc"
	sudo apt-get install -y --install-recommends vlc browser-plugin-vlc vlc-plugin-libde265
fi

# 7z
if [ $Install_P7Zip -eq 1 ]; then
	log $INFO "install p7zip"
	sudo apt-get install -y --install-recommends p7zip p7zip-rar p7zip-full
fi

#qpdfview- lighter than okular and faster than evince: However, limited functionality
if [ $Install_QPDFView -eq 1 ]; then
	log $INFO "install qpdfview"
	sudo apt-get install -y qpdfview
fi

#qbittorrent
if [ $Install_QBitTorrent -eq 1 ]; then
	log $INFO "install qbittorrent"
	sudo apt-get install -y qbittorrent
fi

# gparted
if [ $Install_GParted -eq 1 ]; then
	log $INFO "install gparted"
	sudo apt-get install -y --install-recommends -y gparted
fi

#octave
if [ $Install_Octave -eq 1 ]; then
	log $INFO "install octave"
	sudo add-apt-repository -y ppa:nilarimogard/webupd8
	sudo apt-get install -y --install-recommends liboctave-dev octave
fi

#okular
if [ $Install_Okular -eq 1 ]; then
	log $INFO "install okular"
	sudo apt-get install --install-recommends -y okular
fi

#Uncomment next line to remove OpenJDK
if [ $Install_OracleJava8 -eq 1 ]; then 
	if [ $Remove_OpenJDK -eq 1 ]; then
		log $INFO "PURGE OpenJDK"
		sudo apt-get purge -y openjdk-\*
	fi
	log $INFO "install oraclejava"
	sudo apt-get install -y oracle-java8-installer
	sudo apt-get install -y oracle-java8-set-default
fi

#coding ide
if [ $Install_VisualStudioCode -eq 1 ]; then
	log $INFO "install visual studio code"
	sudo apt-get install -y code
fi
#If you are using VS Code, note that you have to remove the line which modifies \$TMPDIR in your .zprofile.

#sublime
if [ $Install_SublimeText -eq 1 ]; then
	log $INFO "install sublime text"
	sudo apt-get install -y --install-recommends sublime-text 
fi
#google drive (3rd party)
if [ $Install_Grive_GoogleDrive -eq 1 ]; then
	log $INFO "install grive"
	sudo apt-get install -y grive
fi
# tilda and tumix, for terminal
if [ $Install_TildaTmux -eq 1 ]; then
	log $INFO "install tilda"
	sudo apt-get install -y tilda tmux
fi
# atom editor
if [ $Install_Atom -eq 1 ]; then
	log $INFO "install atom"
	sudo apt-get install -y atom
fi

if [ $Install_Docker -eq 1 ]; then
	log $INFO "install docker"
	bash docker.sh 2>>"log_docker.log"
fi

if [ $Install_LibreOffice -eq 1 ]; then
	log $INFO "install libreoffice-stuff"
	echo "installing libreoffice and dependencies!"
	if [ $LibreOffice_Base -eq 1 ]; then
		log $INFO "install libreoffice-base"
		sudo apt-get install -y libreoffice-base
	fi
	if [ $LibreOffice_Draw -eq 1 ]; then
		log $INFO "install libreoffice-draw"
		sudo apt-get install -y libreoffice-draw
	fi
	if [ $LibreOffice_Impress -eq 1 ]; then
		log $INFO "install libreoffice-impress"
		sudo apt-get install -y libreoffice-impress
	fi
	if [ $LibreOffice_Math -eq 1 ]; then
		log $INFO "install libreoffice-math"
		sudo apt-get install -y libreoffice-math
	fi
	if [ $LibreOffice_Writer -eq 1 ]; then
		log $INFO "install libreoffice-writer"
		sudo apt-get install -y libreoffice-writer
	fi
	sudo apt-get install -yf
else
	log $INFO "NOT install libreoffice"
fi

if [ "$1" = "teamviewer" ] || [ ! -z  $Install_TeamViewer ]; then
	if [ ! -z `which teamviewer` ]; then
		log $INFO "teamviewer already installed, download teamviewer debian file"
		echo "teamviewer is already installed! will ONLY download the latest deb file"
		wget -q https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
		echo "teamviewer downloaded. To install, enter the command:"
		echo "sudo dpkg -i teamviewer_amd64.deb"
	else
		log $INFO "install teamviewer"
		wget -q https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
		sudo dpkg -i teamviewer_amd64.deb
		sudo apt-get install -fy
		rm teamviewer_amd64.deb	
	fi
else
	echo "Not installing teamviewer"
fi
exit
