#!/bin/bash
#version 1.0

# Variables
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
blue='\e[1;34m'
cyan='\e[1;36m'
red='\e[1;31m'
pkg install php
pkg install perl
pkg install lolcat
pkg install nmap


echo  "_____________________________________________________________"
echo  "                 => UNDERGROUND CYBER ARMY <=" |lolcat
echo  "                       official website" |lolcat
echo  "                 http://uca-official.zone.id"| lolcat
echo  "_____________________________________________________________"

lagi=1
while [ $lagi -lt 6 ];
do
echo ""
echo  $b "1. Nmap${enda}";
echo  "============================" | lolcat
echo  $b "2. Admin finder ${endcla}";
echo  "============================" | lolcat
echo  $b "3. DDOS UDP type"
echo  "============================" | lolcat
echo  $b "4. Exit${enda}";
echo  "============================" | lolcat

echo ""
echo  "╭─Silahkan Pilih" |lolcat
read -p "╰─>" pil;

# Nmap

case $pil in
1)
echo  "[+] Masukan web" | lolcat

read web
nmap $web
echo

;;

# admin-finder

2)
echo "[+] Masukan Link" | lolcat
read p
php adf.php -u $p
echo

;;

#DDOS

3)
echo "[+] Masukan IP" | lolcat
read a
echo "[+] Masukan port" | lolcat
read b
echo "[+] Masukan Packet" | lolcat
read c
perl udp.pl $a $b $c
echo

;;


4) echo "=>Thanks Udah gunain tools kami<=" | lolcat
exit

;;

esac
done
done
