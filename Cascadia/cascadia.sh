#!/bin/bash
clear
BinaryName="cascadiad"
DirectName=".cascadiad" #database directory
CustomPort="119"
NodeName="Cascadia"  # project folder
ChainID="cascadia_6102-1"
install_binary() {
exec > /dev/null 2>&1
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.7/cascadiad-v0.1.7-linux-amd64 -o cascadiad
sudo chmod u+x cascadiad
sudo cp cascadiad /usr/local/bin/cascadiad
rm -rf cascadiad
exec > /dev/tty 2>&1
}
ge_ad_se_pe() {
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/addrbook.json > $HOME/$DirectName/config/addrbook.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Cascadia/genesis.json > $HOME/$DirectName/config/genesis.json
peers="001933f36a6ec7c45b3c4cef073d0372daa5344d@194.163.155.84:49656,f78611ffa950efd9ddb4ed8f7bd8327c289ba377@65.109.108.150:46656,783a3f911d98ad2eee043721a2cf47a253f58ea1@65.108.108.52:33656,6c25f7075eddb697cb55a53a73e2f686d58b3f76@161.97.128.243:27656,8757ec250851234487f04466adacd3b1d37375f2@65.108.206.118:61556,df3cd1c84b2caa56f044ac19cf0267a44f2e87da@51.79.27.11:26656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:55656,f075e82ca89acfbbd8ef845c95bd3d50574904f5@159.69.110.238:36656,63cf1e7583eabf365856027815bc1491f2bc7939@65.108.2.41:60556,d5ba7a2288ed176ae2e73d9ae3c0edffec3caed5@65.21.134.202:16756"
seeds=""
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/$DirectName/config/config.toml
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025aCC\"/" ~/.cascadiad/config/app.toml
exec > /dev/tty 2>&1
}

snapshot() {
exec > /dev/null 2>&1
sudo apt install liblz4-tool -y
curl -L http://128.140.4.67/CoreNode_Chain_Services/cascadia_snapshot.tar.lz4 | tar -I lz4 -xf - -C $HOME/.cascadiad/data
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
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/core-node.sh | bash
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
ExecStart=$(which $BinaryName) start --home $HOME/$DirectName --chain-id cascadia_6102-1
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
exec > /dev/tty 2>&1
echo -e "\e[0;34mCore Node Chain Services Snapshot İndiriliyor\033[0m"
snapshot
sleep 1
exec > /dev/null 2>&1
systemctl daemon-reload
systemctl enable $BinaryName
systemctl start $BinaryName
systemctl restart $BinaryName
exec > /dev/tty 2>&1
echo " "
echo -e "\e[0;34mNode Başlatıldı. Logları takip etmek için: \033[0;33m           sudo journalctl -u $BinaryName -fo cat\033[0m"
sleep 2
echo " "
sleep 2
source $HOME/.bash_profile
