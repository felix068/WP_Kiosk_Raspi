#!/bin/bash

echo 
echo "== Confirmation... =="
echo 

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
    sudo apt-get update & sudo apt-get full-upgrade
    echo "The software will install..."
    sudo apt-get install xserver-xorg-input-evdev xinput-calibrator xorg unclutter
    sudo cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf
    sudo rm /home/pi/.profile
    sudo rm /home/pi/.xinitrc
    cd /home/pi/
    sudo wget https://raw.githubusercontent.com/felix068/Work_Raspi_Kiosk/main/.profile
    sudo wget https://raw.githubusercontent.com/felix068/Work_Raspi_Kiosk/main/.xinitrc
    cd /
    sudo wget https://raw.githubusercontent.com/felix068/Work_Raspi_Kiosk/main/st.sh
    sudo nano /etc/X11/xorg.conf.d/98-dietpi-disable_dpms.conf
    sudo nano /boot/config.txt
    echo "The operation was done !"
else
    echo "The operation was canceled by the user."
fi
