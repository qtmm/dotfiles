init:
	ln -vsf ${PWD}/.aliases ${HOME}/.aliases
	ln -vsf ${PWD}/.envs ${HOME}/.envs
	ln -vsf ${PWD}/.xprofile ${HOME}/.xprofile
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -vsf ${PWD}/.xkb ${HOME}/.xkb

yay:
	sudo pacman -S --noconfirm --needed base-devel
	sudo pacman -S --noconfirm yay

tools:
	sudo pacman -S --noconfirm \
		fzf evince poppler-data \
		neofetch gcc gdb gnuplot discord
	yay -S downgrade slack-desktop zoom teams

ssh:
	sudo pacman -S --noconfirm openssh
	mkdir -p ${HOME}/.ssh
	chmod 700 ${HOME}/.ssh

dropbox:
	yay -S dropbox
	dropbox

gocryptfs:
	sudo pacman -S gocryptfs
	# mkdir -p ${HOME}/Dropbox/encrypted
	gocryptfs -init ${HOME}/Dropbox/encrypted
	mkdir -p ${HOME}/private
	gocryptfs ${HOME}/Dropbox/encrypted ${HOME}/private

tlp:
	sudo pacman -S --noconfirm tlp
	sudo ln -vsf ${PWD}/tlp.conf /etc/default/tlp.conf
	systemctl enable tlp.service

fonts:
	sudo pacman -S --noconfirm ttf-meslo-nerd-font-powerlevel10k
	sudo pacman -S --noconfirm adobe-source-han-sans-jp-fonts
	yay -S ttf-cica ttf-times-new-roman
	mkdir ${PWD}/FantasqueSansMono
	cd FantasqueSansMono \
	&& curl -L -o FantasqueSansMono.tar.gz \
		https://github.com/belluzj/fantasque-sans/releases/download/v1.8.0/FantasqueSansMono-NoLoopK.tar.gz \
	&& tar xzf FantasqueSansMono.tar.gz
	sudo mv FantasqueSansMono /usr/share/fonts/

fcitx:
	sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc

zsh:
	sudo pacman -S --noconfirm zsh
	ln -vsf ${PWD}/.zprofile ${HOME}/.zprofile
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.zsh ${HOME}/.zsh
	mkdir -p ${HOME}/.zsh/.zinit
	git clone \
		https://github.com/zdharma/zinit.git ${HOME}/.zsh/.zinit/bin

vim:
	sudo pacman -S --noconfirm gvim
	sudo pacman -S --noconfirm libz3
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/.vim ${HOME}/.vim

urxvt:
	sudo pacman -S --noconfirm rxvt-unicode urxvt-perls
	ln -vsf ${PWD}/.Xresources ${HOME}/.Xresources
	xrdb -merge ${HOME}/.Xresources

xterm:
	sudo pacman -S --noconfirm xterm
	ln -vsf ${PWD}/.Xresources ${HOME}/.Xresources
	xrdb -merge ${HOME}/.Xresources

termite:
	sudo pacman -S --noconfirm termite
	mkdir -p ${HOME}/.config/termite
	ln -vsf ${PWD}/.config/termite/config ${HOME}/.config/termite/config

i3wm:
	sudo pacman -S --noconfirm i3-gaps i3status feh jq
	ln -vsf ${PWD}/.config/i3 ${HOME}/.config/i3
	ln -vsf ${PWD}/.config/i3status ${HOME}/.config/i3status

picom:
	sudo pacman -S --noconfirm picom
	ln -vsf ${PWD}/.config/picom.conf ${HOME}/.config/picom.conf

thunderbird:
	sudo pacman -S --noconfirm thunderbird

LaTeX:
	sudo pacman -S --noconfirm texlive-langjapanese texlive-most
	sudo pacman -S --noconfirm kile

docker:
	sudo pacman -S --noconfirm docker docker-compose
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.service

python:
	sudo pacman -S --noconfirm python-pip
	pip install --user --upgrade pip
	pip install --user h5py
	pip install --user matplotlib
	pip install --user numpy
	pip install --user pandas

essential: yay ssh dropbox 
basic: zsh fonts fcitx vim tlp termite urxvt xterm tools i3wm picom init
optional: thunderbird LaTeX docker python gocryptfs

