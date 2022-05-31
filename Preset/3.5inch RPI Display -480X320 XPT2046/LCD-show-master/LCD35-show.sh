#!/bin/bash

sudo ./system_backup.sh

if [ -f /etc/X11/xorg.conf.d/40-libinput.conf ]; then
sudo rm -rf /etc/X11/xorg.conf.d/40-libinput.conf
fi

sudo cp ./usr/tft35a-overlay.dtb /boot/overlays/
sudo cp ./usr/tft35a-overlay.dtb /boot/overlays/tft35a.dtbo

root_dev=`grep -oPr "root=[^\s]*" /boot/cmdline.txt | awk -F= '{printf $NF}'`
if test "$root_dev" = "/dev/mmcblk0p7";then

sudo cp -rf ./boot/config-noobs-nomal.txt ./boot/config.txt.bak

else

sudo cp -rf ./boot/config-nomal.txt ./boot/config.txt.bak

sudo echo "hdmi_force_hotplug=1" >> ./boot/config.txt.bak
fi
sudo echo "dtparam=i2c_arm=on" >> ./boot/config.txt.bak
sudo echo "dtparam=spi=on" >> ./boot/config.txt.bak
sudo echo "enable_uart=1" >> ./boot/config.txt.bak
sudo echo "dtoverlay=tft35a:rotate=90" >> ./boot/config.txt.bak
sudo echo "hdmi_group=2" >> ./boot/config.txt.bak
sudo echo "hdmi_mode=1" >> ./boot/config.txt.bak
sudo echo "hdmi_mode=87" >> ./boot/config.txt.bak
sudo echo "hdmi_cvt 480 320 60 6 0 0 0" >> ./boot/config.txt.bak
sudo echo "hdmi_drive=2" >> ./boot/config.txt.bak

sudo cp -rf ./boot/config.txt.bak /boot/config.txt

sudo cp -rf ./usr/99-calibration.conf-35-90  /etc/X11/xorg.conf.d/99-calibration.conf
sudo cp -rf ./usr/99-fbturbo.conf  /usr/share/X11/xorg.conf.d/99-fbturbo.conf

sudo cp ./usr/inittab /etc/

sudo touch ./.have_installed
echo "gpio:resistance:35:90:480:320" > ./.have_installed

wget --spider -q -o /dev/null --tries=1 -T 10 https://cmake.org/
if [ $? -eq 0 ]; then
sudo apt-get install cmake -y 2> error_output.txt
result=`cat ./error_output.txt`
echo -e "\033[31m$result\033[0m"
grep -q "^E:" ./error_output.txt
type cmake > /dev/null 2>&1
if [ $? -eq 0 ]; then
sudo rm -rf rpi-fbcp
wget --spider -q -o /dev/null --tries=1 -T 10 https://github.com
if [ $? -eq 0 ]; then
sudo git clone https://github.com/tasanakorn/rpi-fbcp
if [ $? -ne 0 ]; then
echo "download fbcp failed, copy native fbcp!!!"
sudo cp -r ./usr/rpi-fbcp .
fi
else
echo "bad network, copy native fbcp!!!"
sudo cp -r ./usr/rpi-fbcp .
fi
sudo mkdir ./rpi-fbcp/build
cd ./rpi-fbcp/build/
sudo cmake ..
sudo make
sudo install fbcp /usr/local/bin/fbcp
cd - > /dev/null
type fbcp > /dev/null 2>&1
if [ $? -eq 0 ]; then
sudo cp -rf ./etc/rc.local /etc/rc.local
fi
else
echo "install cmake error!!!!"
fi
else
echo "bad network, can't install cmake!!!"
fi

version=`uname -v`
version=${version##* }
echo $version
if test $version -lt 2017;then
else
echo "need to update touch configuration"
wget --spider -q -o /dev/null --tries=1 -T 10 http://mirrors.zju.edu.cn/raspbian/raspbian
result=`cat ./error_output.txt`
echo -e "\033[31m$result\033[0m"
grep -q "error:" ./error_output.txt && exit
fi

sudo sync
sudo sync
sleep 1
if [ $# -eq 1 ]; then
sudo ./rotate.sh $1
elif [ $# -gt 1 ]; then
echo "Too many parameters"
fi