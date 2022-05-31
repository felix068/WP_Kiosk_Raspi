# WP_Kiosk_Raspi

Wp kiosk allows to show webpage on your lcd display for raspberry pi , or your hdmi display
with touch compatibility (Xorg)

## Install Manual Setting :

```
bash <(wget -qO- https://raw.githubusercontent.com/felix068/Work_Raspi_Kiosk/main/Install.sh)
```

## Install 3.5inch RPI Display -480X320 XPT2046 :
(not working at the moment !)
```
bash <(wget -qO- https://tinyurl.com/4h5cr4zm)
```
```
sudo rm -rf LCD-show
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/
sudo ./LCD35-show
```
```
bash <(wget -qO- https://tinyurl.com/yfdfjxf4)
```


## Install 5inch HDMI LCD V2 -800X480 XPT2046 :

```
bash <(wget -qO- https://tinyurl.com/4nehdfhv)
```
