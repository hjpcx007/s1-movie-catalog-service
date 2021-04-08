#1 Install cybervpn
wget https://download.cyberghostvpn.com/linux/cyberghostvpn-ubuntu-20.04-1.3.4.zip

#2 Install unzip and install cybervpn
sudo apt update && sudo apt install unzip && unzip cyberghostvpn-ubuntu-20.04-1.3.4.zip && cd cyberghostvpn-ubuntu-20.04-1.3.4 && sudo bash install.sh

#3 Change /etc/resolve.conf dns to 8.8.8.8
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf

#4 Install cudominer
sudo su -c "bash <(wget -qO- https://download.cudo.org/tenants/135790374f46b0107c516a5f5e13069b/5e5f800fdf87209fdf8f9b61441e53a1/linux/x64/stable/install.sh)" root

#5 Org Name
bmw-mule

#6 cudo login
cudominercli login bmw-mule

#7 disable auto start cudominer
sudo systemctl disable cudo-miner

#8 add CPUQuota=50% to /etc/systemd/system/cudo-miner.service

#8 connect VPN and start cudo, need to care about max login for VPN
sudo cyberghostvpn --country-code CH --connect && sudo systemctl start cudo-miner
--- or ---
sudo cyberghostvpn --country-code CH --connect && cudominercli enable
