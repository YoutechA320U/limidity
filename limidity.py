# -*- coding: utf-8 -*-
#!/usr/bin/python3

#オリジナルのソースコード/Original Source
# https://github.com/YoutechA320U/limidity
#ライセンス/Licence
# [MIT] https://github.com/YoutechA320U/limidity/blob/master/LICENSE


import time
import subprocess
import sys
#実行しているユーザーを確認
loginuser=str(subprocess.check_output("sudo who |awk '{print $1}'" ,shell=True).decode('utf-8').strip())

path="/usr/share/sounds/sf2/" #サウンドフォントのパスを入力
sf2="FluidR3_GM.sf2" #サウンドフォントの名前を入力

#time.sleep(3)
subprocess.call('sudo aconnect -x', shell=True)
subprocess.call('sudo killall timidity', shell=True)
time.sleep(1)
#cfgforsfでTimidity++音源コンフィグファイルを作成
subprocess.call('''sudo cfgforsf -C "{0}{1}" | sed -e 's/(null)//' -e 's/^[ ]*//g' -e '/(null)#/d'  -e /^#/d | grep -C 1 % | sudo sed -e '/--/d' -e /^$/d > "/usr/local/share/timidity/{2}.cfg"''' .format(path,sf2,sf2) ,shell=True)
subprocess.call('sudo killall timidity', shell=True)
#Timidity++をユーザー権限で起動。Timidity++設定ファイルは/usr/local/share/timidity/timidity.cfg
subprocess.Popen('sudo -u {0} timidity -c "/usr/local/share/timidity/{1}.cfg"' .format(loginuser,sf2) ,shell=True)
time.sleep(3)
#Timidity++とUSB-MIDIを接続するスクリプトを実行
subprocess.call('sh /usr/local/share/timidity/midiconnect.sh', shell=True)

