#!/bin/bash
clear
BinaryName="noded"
DirectName=".noded" #database directory
CustomPort="111"
NodeName="node"  # project folder
ChainID=" "
install_binary() {
exec > /dev/null 2>&1
git clone ...
cd ...
git checkout ...
make install
exec > /dev/tty 2>&1
}
ge_ad_se_pe() {
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/---/addrbook.json > $HOME/$DirectName/config/addrbook.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/----/genesis.json > $HOME/$DirectName/config/genesis.json
peers=""
seeds=""
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/$DirectName/config/config.toml
# min gas price
exec > /dev/tty 2>&1
}

init() {
exec > /dev/null 2>&1
$BinaryName config chain-id $ChainID
$BinaryName config keyring-backend test
$BinaryName config node tcp://localhost:${CustomPort}57
$BinaryName init $MONIKER --chain-id $ChainID > $HOME/init.txt
exec > /dev/tty 2>&1
}

config() {
exec > /dev/null 2>&1
# set max in-out peers
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/$DirectName/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/$DirectName/config/config.toml
# puruning
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/$DirectName/config/app.toml
# indexer
sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/$DirectName/config/config.toml
# custom port
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${CustomPort}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${CustomPort}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${CustomPort}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${CustomPort}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${CustomPort}66\"%" $HOME/$DirectName/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${CustomPort}17\"%; s%^address = \":8080\"%address = \":${CustomPort}80\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${CustomPort}90\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${CustomPort}91\"%; s%:8545%:${CustomPort}45%; s%:8546%:${CustomPort}46%; s%:6065%:${CustomPort}65%" $HOME/$DirectName/config/app.toml
sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://localhost:${CustomPort}17\"%; s%^address = \":8080\"%address = \":${CustomPort}80\"%; s%^address = \"localhost:9090\"%address = \"localhost:${CustomPort}90\"%; s%^address = \"localhost:9091\"%address = \"localhost:${CustomPort}91\"%; s%:8545%:${CustomPort}45%; s%:8546%:${CustomPort}46%; s%:6065%:${CustomPort}65%" $HOME/$DirectName/config/app.toml
exec > /dev/tty 2>&1
}

get_moniker () {
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 2
}

removenode() {
exec > /dev/null 2>&1
sudo systemctl stop $BinaryName && \
sudo systemctl disable $BinaryName && \
rm /etc/systemd/system/$BinaryName.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf $DirectName && \
rm -rf $NodeName && \
rm -rf $(which $BinaryName)
exec > /dev/tty 2>&1
}

curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/matrix.sh | bash
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/socrates.sh | bash
echo -e "\e[0;34m$NodeName Kurulumu Başlatılıyor\033[0m"
sleep 2
echo " "
get_moniker
echo -e "\e[0;34mSunucu Hazırlanıyor\033[0m"
removenode
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/preparing-server.sh | bash
echo -e "\e[0;33mGüncellendi, Kütüphaneler Kuruldu, $(go version) Kuruldu\033[0m"
sleep 2
echo " "
echo -e "\e[0;34m$BinaryName Kuruluyor\033[0m"
install_binary
echo -e "\e[0;33m$BinaryName $($BinaryName version) Kuruldu\033[0m"
sleep 2
init
echo " "
echo -e "\e[0;34m$BinaryName Başlatıldı\033[0m"
sleep 2
echo " "
echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
config
ge_ad_se_pe
sleep 2
echo -e "\e[0;33mTamamlandı\033[0m"
exec > /dev/null 2>&1
sudo tee /etc/systemd/system/$BinaryName.service > /dev/null <<EOF
[Unit]
Description=$NodeName Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which $BinaryName) start --home $HOME/$DirectName
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sleep 2
systemctl daemon-reload
systemctl enable $BinaryName
systemctl start $BinaryName
systemctl restart $BinaryName
exec > /dev/tty 2>&1
echo " "
echo -e "\e[0;34mNode Başlatıldı. Logları takip etmek için: \033[0;33m           sudo journalctl -u $BinaryName -fo cat\033[0m"
sleep 2
echo " "
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/socrates.sh | bash
sleep 2
source $HOME/.bash_profile
