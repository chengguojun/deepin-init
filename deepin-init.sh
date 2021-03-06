#!/bin/bash

#先进到用户下载目录
cd ~/Downloads

#替换成163的源
sudo sh -c 'echo "deb [by-hash=force] https://mirrors.cloud.tencent.com/deepin/ lion main contrib non-free" > /etc/apt/sources.list'

#添加Chrome源到source.list.d
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

#添加VSCode源到source.list.d
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#添加Docker源到source.list.d
wget -q -O - https://mirrors.cloud.tencent.com/docker-ce/linux/debian/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list'

#添加Typora源到source.list.d
wget -q -O - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo sh -c 'echo "deb https://typora.io/linux ./" > /etc/apt/sources.list.d/typora.list'

#添加yarn源到source.list.d
wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list'

#添加mysql源到source.list.d
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
sudo sh -c 'echo "deb [arch=amd64] https://mirrors.cloud.tencent.com/mysql/apt/debian/ stretch mysql-8.0" > /etc/apt/sources.list.d/mysql.list'

#卸载系统自带Flash（Chrome会自动更新的）
sudo apt-get purge -y libflashplugin-pepper
rm -rf ~/.config/google-chrome/PepperFlash/

#卸载自带QQ（原因不解释，我喜欢TIM）
sudo apt-get purge -y deepin.com.qq.im

#卸载深度帮助手册和深度欢迎两个没用还占地方的东西（会同时卸载dde，貌似没啥问题）
sudo apt-get purge -y deepin-manual
sudo apt-get purge -y dde-introduction

#卸载自己不需要的软件
sudo apt-get purge -y thunderbird
sudo apt-get purge -y deepin-feedback
sudo apt-get purge -y deepin-appstore*
sudo apt-get purge -y deepin-music
sudo apt-get purge -y deepin-calculator
sudo apt-get purge -y deepin-deepinid-client
sudo apt-get purge -y deepin-sync-daemon
sudo apt-get purge -y deepin-cloud-scanner
sudo apt-get purge -y printer-driver-deepin-cloud-print
sudo apt-get purge -y deepin-screensaver*
sudo apt-get purge -y deepin-voice-recorder
sudo apt-get purge -y deepin-screen-recorder
sudo apt-get purge -y simple-scan
sudo apt-get purge -y flatpak
sudo apt-get purge -y plymouth-theme-deepin-logo

#安装软件
sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install -y curl
sudo apt-get install -y console-setup
sudo apt-get install -y deepin-screenshot
sudo apt-get install -y deepin-image-viewer
sudo apt-get install -y dde-calendar
sudo apt-get install -y qt5-qmake
sudo apt-get install -y code
sudo apt-get install -y deepin.com.qq.office
sudo apt-get install -y --no-install-recommends openjdk-8-jdk
sudo apt-get install -y docker-ce
sudo apt-get install -y typora
sudo apt-get install -y --no-install-recommends yarn
sudo apt-get install -y mysql-server

#安装向日葵
wget -t 3 -T 15 http://download.oray.com/sunlogin/linux/SunloginClient-10.0.2.24779_amd64.deb
sudo dpkg -i SunloginClient-10.0.2.24779_amd64.deb

#安装Lantren
wget -t 3 -T 15 https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
sudo dpkg -i lantern-installer-64-bit.deb

#删除Chrome推荐设置
sudo rm /etc/opt/chrome/policies/recommended/*.json

#更新TIM到最新版本
sh -c  '/opt/deepinwine/apps/Deepin-TIM/run.sh -c'
export WINEPREFIX=$HOME/.deepinwine/Deepin-TIM
rm TIM2.3.2.21173.exe
wget -t 3 -T 15 https://dldir1.qq.com/qqfile/qq/TIM2.3.2/21173/TIM2.3.2.21173.exe
deepin-wine TIM2.3.2.21173.exe

# 修改开机logo为详细信息（个人喜好）
sudo plymouth-set-default-theme -R details

#清理一下
sudo apt-get autoremove --purge
