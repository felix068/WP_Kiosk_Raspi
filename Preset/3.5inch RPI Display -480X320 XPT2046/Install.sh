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
    sudo apt-get install xserver-xorg-input-evdev xserver-xorg xinput-calibrator xorg unclutter chromium-browser git -y
    sudo cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf
    sudo rm /home/pi/.profile
    sudo rm /home/pi/.xinitrc
    cd /home/pi/
    sudo wget https://raw.githubusercontent.com/felix068/Working_Raspi_Kiosk/main/.profile
    cd /
    sudo wget https://raw.githubusercontent.com/felix068/Working_Raspi_Kiosk/main/st.sh
    echo -e "\033[31m The program setting your config file \033[0m"
    sudo rm /boot/config.txt
    cd /boot/
    sudo wget "https://raw.githubusercontent.com/felix068/WP_Kiosk_Raspi/main/Preset/3.5inch%20RPI%20Display%20-480X320%20XPT2046/config.txt"
    

    

    
    echo -e "\033[31m Setting Xorg (X11) \033[0m"
    sleep 3
    sudo nano /etc/X11/xorg.conf.d/98-dietpi-disable_dpms.conf
    echo -e "\033[31m Setting your screen resolution and chromium argument \033[0m"
    cd /home/pi/
    sudo rm .xinitrc
    sudo wget "https://raw.githubusercontent.com/felix068/WP_Kiosk_Raspi/main/Preset/3.5inch%20RPI%20Display%20-480X320%20XPT2046/.xinitrc"
    echo -e "\033[31m The operation was done ! \033[0m"
    cd /home/pi/
    
    sudo rm -rf LCD-show
    git clone https://github.com/goodtft/LCD-show.git
    chmod -R 755 LCD-show
    cd LCD-show/
    sudo ./LCD35-show
    
    sudo rm /usr/share/X11/xorg.conf.d/99-fbturbo.conf
    sudo rm /etc/X11/xorg.conf.d/99-calibration.conf 
    
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
