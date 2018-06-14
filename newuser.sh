#!/bin/bash
dirt=$(pwd)
pw=$(apg -n 1 -M NCL -x 10)
sudo useradd -m $1 -p $pw -G adm
#sudo adduser $1 sudo
#sudo passwd $1
echo $1 $pw
#sudo chown root:root /home/$1
sudo mkdir /home/$1/.ssh
sudo chown $1:$1 /home/$1/.ssh
sudo chmod 777 /home/$1
#sudo usermod -d /home/$1 $1

mailto=$(cat ./mailto)
mailfrom=$(cat ./mailfrom)
message="User id:  $1 

\n
Password:  $pw
\n
\n"

cd /home/$1/.ssh
sudo ssh-keygen -t rsa -b 4096 -N "" -C "$1 user key" -f tour_$1.pem -q
sudo  puttygen tour_$1.pem -o tour_$1.ppk
#sudo cp -u /etc/ssh/authorized_keys ~/.ssh/
#sudo cat authorized_keys  > authorized_keys_backup_b4$1
sudo cp -u tour_$1.pem.pub  authorized_keys
sudo cp -u tour_$1.pem  ~/.ssh
echo `pwd`'/'tour_$1.pem
#sudo mail -s "TourneyGo - Dev " -a tour_$1.pem -a tour_$1.ppk  -r $mailfrom $mailto $2 <<< `echo -e $message`
echo  -e $message | sudo mail -s "TourneyGo - Dev " -a tour_$1.pem -a tour_$1.ppk  -r $mailfrom $mailto $2 
sudo chown $1:$1 /home/$1/.ssh/*
sudo chmod 700 -R /home/$1/.ssh
cd $dirt
sudo chmod 700 /home/$1
