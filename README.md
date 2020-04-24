## Limidity

Debian系LinuxPCをTimidity++でハードウェアMIDI音源みたいにするスクリプトです。

## ライセンス
Limidityは主にTimidity++など複数のソフトウェアで構成されています。他のソフトウェアのライセンスはそのソフトウェアの元々のライセンスに準じます。Limidityのソースコードそのものは[MITライセンス](https://github.com/YoutechA320U/Limidity/blob/master/LICENSE)となっています。

## 概要
Debian、Raspbian、UbuntuなどDebian系LinuxPCをハードウェアMIDI音源みたいにするスクリプトです

## スペック
    *GM/GS/XG/エクスクルーシブメッセージ対応*
    *Timidity++ version 2.15.0*
    
    OS:Debian系Linux(arm,x86,amd64)
    パート数:16(デフォルト)
    最大同時発音数:128(デフォルト)
    音源:サウンドフォント(.sf2) ※デフォルトはFluidR3_GM.sf2
    サンプリングレート:32000Hz(デフォルト)

## 開発環境
    OS : UbuntuMATE18.04LTS(amd64)
    PC : VirtualBox 6.1.6 r137129 (Qt5.6.2)
    Python : ver3.7

## 必要な部品
|部品名|備考|数量|
|:---|:--:|---:|
|PC|RaspberryPi 2Bなど(※最低ライン)|1|
|OS|Debian系LinuxOS||
|USB-MIDIインターフェース、USB-MIDIキーボードなどノートオンメッセージを送れるUSB-MIDI機器|激安品は避けた方が吉|1|
|(お好みで)サウンドフォント|搭載メモリの半分程度まで||

## インストール方法と使い方
※仮想マシン上のUbuntuMATE18.04LTS(amd64)で説明します

1. 何らかの手段でダウンロードした二つのスクリプト[limidity_setup.sh](https://github.com/YoutechA320U/limidity/blob/master/limidity_setup.sh), [limidity.py](https://github.com/YoutechA320U/limidity/blob/master/limidity.py)を適当な場所に置きます

2. PCのUSBポートにUSB-MIDI機器を1つ接続してください

3. 最初のみターミナルから`limidity_setup.sh`セットアップスクリプトをスーパーユーザー権限でシェルスクリプトで一回実行します。 例:`sudo sh limidity_setup.sh`

4. 完了したらターミナルから`limidity.py`をスーパーユーザー権限でPython3で一回実行します。これはPCを起動するたびに行ってください。 例:`sudo python3 limidity.py`

5. USB-MIDI-機器からノートオンなどを送るとPCのオーディオ出力から音がでるはずです

## 備考
扱いやすくするために手動で実行する事を想定していますが自動化してUIなど機能を追加すればスタンドアロンなハードウェアMIDI音源が作れるはずです。

Timidity++の設定ファイルは`/usr/local/share/timidity/timidity.cfg`です。ここを書き換えると各種パラメータを調整できます。内容はデフォルトの`timidity.cfg`や`timidity -h`コマンド、下記参考ページを参照してください

質問やバグの報告は[このリポジトリのIssue](https://github.com/YoutechA320U/limidity/issues)か[作者のTwitter](https://twitter.com/YoutechA320U)へお願いします。

### 参考コード・資料
 * <https://forums.ubuntulinux.jp/viewtopic.php?id=3060>  
 * <https://github.com/YoutechA320U/ysynth4>  
 * <http://d.hatena.ne.jp/kakurasan/20080409/p1>
 * <http://bluewing.usamimi.info/timidity/index.php?p=index&lang=ja>

## 履歴
    [2020/04/24] - 初回リリース
