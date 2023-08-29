#!/bin/bash

WKDIR="$(pwd)"
FLDIR="othros"
BLDDIR="othros"

[[ -f /usr/share/live/build/hooks/normal/9000-remove-gnome-icon-cache.hook.chroot ]] && rm /usr/share/live/build/hooks/normal/9000-remove-gnome-icon-cache.hook.chroot

echo "============================================================================="
echo -e "[*]                 ____  _             _     _                         [*]"
echo -e "[*]                / ___|| |_ __ _ _ __| |_  | |                        [*]"
echo -e "[*]                \___ \| __/ _\` | '__| __| | |                        [*]"
echo -e "[*]                 ___) | || (_| | |  | |_  |_|                        [*]"
echo -e "[*]                |____/ \__\__,_|_|   \__| (_)                        [*]"
echo -e "[*]                The script is starting the build process...           [*]"
echo "=============================================================================="

mkdir $BLDDIR
cd $BLDDIR

lb config --binary-images iso-hybrid --mode debian --architectures amd64 --linux-flavours amd64 --distribution bookworm --archive-areas "main contrib non-free non-free-firmware" --updates true --security true --cache true --apt-recommends true --firmware-binary true --firmware-chroot true --win32-loader false --iso-application $BLDDIR --iso-preparer SoP-https://systemofpekalongan.rf.gd/ --iso-publisher SoP-https://systemofpekalongan.rf.gd --image-name "$BLDDIR-$(date -u +"%y%m%d")" --iso-volume "$BLDDIR-$(date -u +"%y%m%d")" --checksums sha512 --clean --color

# Add Kali Linux repository
echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" > $WKDIR/$BLDDIR/config/archives/kali.list.chroot

# Specify Kali tools to be installed
echo "kali-tools" > $WKDIR/$BLDDIR/config/package-lists/kalitools.list.chroot

# Specify Debian packages to be installed
echo "accountsservice alsa-utils cups cups-filters curl dbus-user-session dbus-x11 dconf-cli foomatic-db foomatic-db-engine fuse3 ghostscript gnome-keyring grub-pc gvfs-backends gvfs-fuse iw libnss-mdns libsmbclient light-locker lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lsb-release mousepad netcat-openbsd network-manager-gnome network-manager-openconnect-gnome network-manager-openvpn-gnome os-prober pavucontrol perl plymouth plymouth-label plymouth-themes policykit-1 printer-driver-gutenprint pulseaudio samba-common-bin sudo synaptic system-config-printer udisks2 upower xclip xdg-utils xfce4 xfce4-goodies xfce4-power-manager xfce4-terminal xorg xserver-xorg-input-all xserver-xorg-video-all xterm" > $WKDIR/$BLDDIR/config/package-lists/xfcedesktop.list.chroot

echo "aisleriot apt-transport-https zsh zsh-common arc-theme asunder atril audacious audacious-plugins autoconf automake bleachbit breeze-gtk-theme breeze-icon-theme btrfs-progs build-essential cdtool cdrdao cdrskin cifs-utils clonezilla cryptsetup cryptsetup-initramfs debconf debhelper dh-autoreconf dialog dirmngr dkms dos2unix dosbox dosfstools dvdauthor exfatprogs faac faad fakeroot firefox-esr flac frei0r-plugins gdebi gimp gir1.2-ibus-1.0 gnome-disk-utility gnome-nettool gnome-system-tools gparted greybird-gtk-theme grsync gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good gthumb guvcview hardinfo haveged hplip-gui htop hunspell-en-us hyphen-en-us ibus ibus-data ibus-gtk ibus-gtk3 iftop im-config inxi isolinux jfsutils keepassxc lame less libegl1-mesa libibus-1.0-5 libgl1-mesa-glx libqt5opengl5 libxcb-xtest0 libxvidcore4 linux-headers-amd64 lshw meld mencoder menu mtools mythes-en-us neofetch ntfs-3g numix-gtk-theme nvidia-detect openconnect openvpn openvpn-systemd-resolved pciutils python3-ibus-1.0 rar remmina simple-scan simplescreenrecorder smplayer smplayer-l10n smplayer-themes soundconverter sox squashfs-tools streamripper syslinux syslinux-common tango-icon-theme testdisk timeshift transmission-gtk twolame unrar unzip webext-keepassxc-browser wget x265 x264 xarchiver xfsprogs xorriso xscreensaver qterminal zip zstd zulucrypt-gui zulumount-gui" > $WKDIR/$BLDDIR/config/package-lists/extrapackages.list.chroot

echo "efibootmgr grub-common grub-pc-bin grub2-common grub-efi-amd64 grub-efi-amd64-bin grub-efi-amd64-signed grub-efi-ia32-bin libefiboot1 libefivar1 mokutil os-prober shim-helpers-amd64-signed
shim-signed shim-signed-common shim-unsigned" > $WKDIR/$BLDDIR/config/package-lists/grubs.list.binary

mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/etc/
cp -r $WKDIR/$FLDIR/calamares/ $WKDIR/$BLDDIR/config/includes.chroot/etc/

echo "calamares calamares-settings-debian" > $WKDIR/$BLDDIR/config/package-lists/calamares.list.chroot

mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/etc/skel/.config/
mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/usr/share/backgrounds/
mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/usr/share/icons/default/
mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/usr/share/applications/
mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/usr/bin/
mkdir -p $WKDIR/$BLDDIR/config/includes.chroot/opt
###################################################################################
cp -r $WKDIR/$FLDIR/xfce4/ $WKDIR/$BLDDIR/config/includes.chroot/etc/skel/.config/
cp -r $WKDIR/$FLDIR/config/* $WKDIR/$BLDDIR/config/includes.chroot/etc/skel/.config/
cp -r $WKDIR/$FLDIR/ $WKDIR/$BLDDIR/config/includes.chroot/usr/share/
cp -r $WKDIR/$FLDIR/tools/* $WKDIR/$BLDDIR/config/includes.chroot/opt
cp -r $WKDIR/$FLDIR/bootloaders/ $WKDIR/$BLDDIR/config/
cp $WKDIR/$FLDIR/scripts/* $WKDIR/$BLDDIR/config/includes.chroot/usr/bin/
cp -r $WKDIR/$FLDIR/backgrounds/* $WKDIR/$BLDDIR/config/includes.chroot/usr/share/backgrounds/
cp -r $WKDIR/$FLDIR/icons/* $WKDIR/$BLDDIR/config/includes.chroot/usr/share/icons/default/
#cp $WKDIR/$FLDIR/launchers/ezadmin.desktop $WKDIR/$BLDDIR/config/includes.chroot/usr/share/applications/
ln -s /usr/share/$FLDIR $WKDIR/$BLDDIR/config/includes.chroot/etc/skel/$FLDIR

# Uncomment below line if you have packages in the misc64 folder to include:
# cp $WKDIR/$FLDIR/misc64/* $WKDIR/$BLDDIR/config/packages.chroot/

# Downloading Kali Linux repository configuration
echo "deb https://http.kali.org/kali kali-rolling main non-free contrib" > $WKDIR/$BLDDIR/config/archives/kali.list.chroot

# Changing hostname
echo "othros" > $WKDIR/$BLDDIR/config/includes.chroot/etc/hostname

# Changing OS name
sed -i 's|eznixos|othros|g' $WKDIR/$BLDDIR/config/includes.chroot/etc/os-release

# Setting live user password
sed -i 's|eznix|othroslive|g' $WKDIR/$BLDDIR/config/includes.chroot/etc/calamares/settings.conf

lb build
