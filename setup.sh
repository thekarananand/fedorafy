
touch .hushlogin

# Remove Bloatware
sudo dnf remove -y *background*
sudo dnf remove -y gnome-boxes
sudo dnf remove -y gnome-browser-connector
sudo dnf remove -y gnome-classic-session
sudo dnf remove -y gnome-connections
sudo dnf remove -y gnome-contacts
sudo dnf remove -y gnome-keyring
sudo dnf remove -y gnome-keyring-pam
sudo dnf remove -y gnome-maps
sudo dnf remove -y gnome-online-accounts
sudo dnf remove -y gnome-photos
sudo dnf remove -y gnome-remote-desktop
sudo dnf remove -y gnome-shell-extension-*
sudo dnf remove -y gnome-system-monitor
sudo dnf remove -y gnome-themes-extra
sudo dnf remove -y gnome-themes-extra
sudo dnf remove -y gnome-tour
sudo dnf remove -y gnome-terminal
sudo dnf remove -y gnome-user-share
sudo dnf remove -y gnome-video-effects
sudo dnf remove -y gnome-weather
sudo dnf remove -y libreoffice-calc
sudo dnf remove -y libreoffice-core
sudo dnf remove -y libreoffice-data
sudo dnf remove -y libreoffice-emailmerge
sudo dnf remove -y libreoffice-filters 
sudo dnf remove -y libreoffice-graphicfilter 
sudo dnf remove -y libreoffice-gtk3
sudo dnf remove -y libreoffice-gtk4
sudo dnf remove -y libreoffice-help-en 
sudo dnf remove -y libreoffice-impress 
sudo dnf remove -y libreoffice-langpack-en 
sudo dnf remove -y libreoffice-ogltrans
sudo dnf remove -y libreoffice-opensymbol-fonts
sudo dnf remove -y libreoffice-pdfimport 
sudo dnf remove -y libreoffice-pyuno 
sudo dnf remove -y libreoffice-ure 
sudo dnf remove -y libreoffice-ure-common
sudo dnf remove -y libreoffice-writer
sudo dnf remove -y libreoffice-x11 
sudo dnf remove -y libreoffice-xsltfilter 
sudo dnf remove -y rhythmbox
sudo dnf remove -y mediawriter
sudo dnf remove -y baobab
sudo dnf remove -y totem*
sudo dnf remove -y gnome-initial-setup
sudo dnf remove -y yelp
sudo dnf remove -y simple-scan
sudo dnf remove -y gnome-software
sudo dnf remove -y gnome-calendar

# DNF Config 
sudo sh -c 'cat << EOF >> /etc/dnf/dnf.conf
fastestmirror=True
max_parallel_downloads=10
EOF'

sudo dnf clean all
sudo dnf autoremove

# Get RPM Fusion
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Get Updates
sudo dnf update -y

# Install DNF Packages
sudo dnf install -y jetbrains-mono-fonts
sudo dnf install -y powerline-fonts
sudo dnf install -y git
sudo dnf install -y gh
sudo dnf install -y gnome-shell-extension-pop-shell
sudo dnf install -y vlc
sudo dnf install -y blackbox-terminal
sudo dnf install -y nautilus

# Install Flatpak Packages
sudo flatpak install -y flathub app/com.raggesilver.BlackBox/x86_64/stable
sudo flatpak install -y flathub app/org.onlyoffice.desktopeditors/x86_64/stable

# Setup Synth Shell
git clone --recursive https://github.com/andresgongora/synth-shell-prompt.git
synth-shell-prompt/setup.sh

rm ~/.config/synth-shell/synth-shell-prompt.root.config 
rm -rf ~/.config/synth-shell/examples
sed -i 's/format="USER HOST PWD GIT PYENV TF KUBE"/format="USER PWD GIT PYENV TF KUBE"/' ~/.config/synth-shell/synth-shell-prompt.config 
sed -i 's/font_color_pwd="dark-gray"/font_color_pwd="black"/' ~/.config/synth-shell/synth-shell-prompt.config 
sed -i 's/font_color_git="light-gray"/font_color_git="white"/' ~/.config/synth-shell/synth-shell-prompt.config
sed -i 's/font_color_input="45"/font_color_input="white"/' ~/.config/synth-shell/synth-shell-prompt.config
rm -rf ~/synth-shell-prompt

# Mouse & Trackpad Config
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono Medium 12'

# Add Minimize Button
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,close'

# Enable Fractional Scaling Option.
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

# Better BlackBox Config
gsettings set com.raggesilver.BlackBox font 'JetBrains Mono Medium 12'
gsettings set com.raggesilver.BlackBox opacity 90

# Add Media Codecs
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-plugin-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
