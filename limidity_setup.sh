#!/bin/sh

#オリジナルのソースコード/Original Source
# https://github.com/YoutechA320U/limidity
#ライセンス/Licence
# [MIT] https://github.com/YoutechA320U/limidity/blob/master/LICENSE

#必要なパッケージのインストール
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get -y autoremove
sudo apt-get install -y libasound2-dev build-essential python3-dev libpython3.7-dev libjack-jackd2-dev python3-setuptools fluid-soundfont-gm

sudo mkdir /usr/local/share/timidity/

#cfgforsとTimidityのビルド&インストール
if [ `timidity -v |grep -m1 version |awk '{print $3}'| grep -v ^$` = "2.15.0" ]; then
  echo "Timidity++は最新のバージョンです"
else
  echo "Timidity++をバージョンアップします"
  cd /usr/local/share/timidity/
  rm *.patch
  rm *.tar.bz2
  wget https://raw.githubusercontent.com/YoutechA320U/limidity/master/timidity%2B%2B-2.15.0-cfgforsf-src.patch
  sudo apt-get remove -y timidity
  wget https://excellmedia.dl.sourceforge.net/project/timidity/TiMidity%2B%2B/TiMidity%2B%2B-2.15.0/TiMidity%2B%2B-2.15.0.tar.bz2
  tar jxf /usr/local/share/timidity/TiMidity++-2.15.0.tar.bz2
  cd TiMidity++-2.15.0/
  ./configure --without-x --enable-audio=alsa --enable-interface=alsaseq --enable-dynamic=alsaseq
  make -j4
  sudo make install
  patch -p1 < /usr/local/share/timidity/timidity++-2.15.0-cfgforsf-src.patch
  ./configure --disable-audio --without-x
  for dir in libarc utils; do make -C ${dir}; done
  cd timidity/
  make -j4 newton_table.c
  for f in common controls instrum sbkconv sffile sfitem sndfont tables version mt19937ar quantity smplfile filter freq resample ../interface/dumb_c; do gcc -DCFG_FOR_SF -DHAVE_CONFIG_H -I. -I../ -I../utils -I../libarc -c ${f}.c; done
  gcc -o cfgforsf common.o controls.o instrum.o sbkconv.o sffile.o sfitem.o sndfont.o tables.o version.o mt19937ar.o quantity.o smplfile.o filter.o freq.o resample.o dumb_c.o -L../libarc -L../utils -lm -larc -lutils
  mv cfgforsf /usr/local/bin/
  cd /usr/local/share/timidity/
  rm /usr/local/share/timidity/TiMidity++-2.15.0/ -fr
  rm *.tar.bz2
fi
cd /usr/local/share/timidity/

#Timidity設定ファイルの生成
sudo sh -c "echo 'opt iA\nopt Os\nopt --sequencer-ports=1\nopt --realtime-priority=50\nopt B3,7\nopt q0-0\nopt s32kHz\nopt -EFresamp=1\nopt -EFreverb=1\nopt -EFchorus=1\nopt p128a' > /usr/local/share/timidity/timidity.cfg"
#midiconnect.sh生成
sudo sh -c "echo 'aconnect 20:0 128:0\naconnect 20:0 129:0\naconnect 20:0 130:0\naconnect 20:0 131:0\naconnect 24:0 128:0\naconnect 24:0 129:0\naconnect 24:0 130:0\naconnect 24:0 131:0' > /usr/local/share/timidity/midiconnect.sh"
sudo chmod +x /usr/local/bin/*
#USB-MIDI機器を自動接続するルールを追加
wget https://raw.githubusercontent.com/YoutechA320U/limidity/master/90-usbmidiconnect.rules
sudo cp /usr/local/share/timidity/90-usbmidiconnect.rules /etc/udev/rules.d/

#再起動
#sudo reboot
