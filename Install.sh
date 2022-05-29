#!/bin/bash
echo 
echo "== Confirmation... =="
confirm()
{
    read -r -p "${1} [Y/n] " answer
    case "$answer" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}
if confirm "Are you sure to install the program?"; then
    sudo apt-get update & sudo apt-get full-upgrade -y
    echo "The software will install..."
    sudo apt-get install xserver-xorg-input-evdev xinput-calibrator xorg unclutter chromium-browser -y
    sudo cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf
    sudo rm /home/pi/.profile
    sudo rm /home/pi/.xinitrc
    cd /home/pi/
    sudo wget https://raw.githubusercontent.com/felix068/Working_Raspi_Kiosk/main/.profile
    sudo wget https://raw.githubusercontent.com/felix068/Working_Raspi_Kiosk/main/.xinitrc
    cd /
    sudo wget https://raw.githubusercontent.com/felix068/Working_Raspi_Kiosk/main/st.sh
    echo "Setting your config file"
    sleep 2
    sudo nano /boot/config.txt
    echo "Setting Xorg (X11)"
    sleep 2
    sudo nano /etc/X11/xorg.conf.d/98-dietpi-disable_dpms.conf
    echo "Setting your screen resolution and chromium argument"
    sleep 2
    sudo nano /home/pi/.xinitrc
    echo "The operation was done !"
else
    echo "The operation was canceled by the user."
fi
