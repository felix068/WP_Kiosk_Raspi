#!/bin/bash
echo 
echo -e "\033[31m == Confirmation... == \033[0m"
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
if confirm "Are you sure to install the program ?"; then
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
    echo -e "\033[31m The program setting your config file \033[0m"
    sudo rm /boot/config.txt
    cd /boot/
    sudo wget ""https://raw.githubusercontent.com/felix068/WP_Kiosk_Raspi/main/Preset/5inch%20HDMI%20LCD%20V2%20-800X480%20XPT2046/config.txt""
    echo -e "\033[31m The program setting Xorg (X11) \033[0m"
    cd /etc/X11/xorg.conf.d/
    sudo wget ""https://raw.githubusercontent.com/felix068/WP_Kiosk_Raspi/main/Preset/5inch%20HDMI%20LCD%20V2%20-800X480%20XPT2046/98-dietpi-disable_dpms.conf""
    echo -e "\033[31m The program setting your screen resolution and chromium argument \033[0m"
    echo -e "\033[31m The operation was done ! \033[0m"
    cd /home/pi
else
    echo "The operation was canceled by the user."
fi

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
if confirm "Do you want to restart ?"; then
    echo "Reboot."
    sudo reboot
else
    echo "The operation was canceled."
fi
