#!/bin/bash
clear
BinaryName="quicksilverd"
DirectName=".quicksilverd" #database directory
CustomPort="111"
NodeName="quicksilver"  # project folder
ChainID="quicksilver-2"
install_binary() {
exec > /dev/null 2>&1
cd $HOME
rm -rf quicksilver
git clone https://github.com/ingenuity-build/quicksilver.git
cd quicksilver
git checkout v1.2.17
make install
exec > /dev/tty 2>&1
}
ge_ad_se_pe() {
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Mainnet/addrbook.json > $HOME/$DirectName/config/addrbook.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Mainnet/genesis.json > $HOME/$DirectName/config/genesis.json
peers="79c85a81d055b41008c2b4bdf47c950d3aecf5cc@65.108.129.239:10656,97e4468ac589eac505a800411c635b14511a61bb@169.155.47.144:26656,cc091c4d385e449a718fb252de800a9caf01913f@95.217.225.212:11656,c6ff8c00fe62d98966c4a1f5072daeb9ffe9a144@95.214.52.166:25656,2309e82e7200ac8a81f1e1f57b3ee604a20af853@51.79.177.229:26667,c950a736496bec7abb89ff137e4c698fc061d9d4@193.34.212.165:36656,072c61dee7f205b237aae0eca698aa4a0639d93e@95.214.54.28:26356,89757803f40da51678451735445ad40d5b15e059@169.155.44.196:26656,3a5d0b97feb595375c24665dcf17d793be129e8b@51.89.155.2:28656,c124ce0b508e8b9ed1c5b6957f362225659b5343@134.65.192.12:26656,218078f9caa4253dc5228995f86e8d7ff65d0e04@54.39.107.110:26656,ddc359f7a5606a8adac2ba46a02c733dbc893fcb@54.177.253.23:26656,ff5643307ca6161d2e93b0126077a2bfd0f00b4b@65.108.203.149:30014,914bed178748772d7578d119cb2dc89d5076b9f4@135.181.223.115:2390,6053a39e67c6bae83430e354f53d99e160e4964b@65.109.28.177:28656,4aa6607f87ad0b458526d3405731e71553cf275c@219.100.163.35:26656,41fe8da4c67864723bf21055135954e0f6951c84@148.251.92.34:36656,5b63379fec9edfd0b1b475ae4d67c08bcb4abdc6@51.89.98.102:48656,67c3cc1397d0a0f03a45d4cae6ff3380be7364f9@95.217.229.18:11656,b4bcce87121963e1e97619dc135f2eb1a9fd5dfc@88.198.32.17:36656,6fefa26a43bffbfaa5668612c070e83598b58d21@[2a02:c206:2093:4875::1]:26656"
seeds=""
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/$DirectName/config/config.toml
# min gas price
sed -i 's|minimum-gas-prices =.*|minimum-gas-prices = "0.0uqck"|g' $HOME/.quicksilverd/config/app.toml
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.quicksilverd/config/config.toml
exec > /dev/tty 2>&1
}
snapshot() {
exec > /dev/null 2>&1
sudo apt install liblz4-tool -y
curl https://mainnet-files.itrocket.net/quicksilver/snap_quicksilver.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.quicksilverd
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
sed -i -e "s/^indexer *=.*/indexer = \"null\"/" $HOME/.quicksilverd/config/config.toml
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
echo -e "\e[0;34m$BinaryName Kuruluyor\033[0m"
install_binary
echo -e "\e[0;33m$BinaryName $($BinaryName version) Kuruldu\033[0m"
sleep 2
init
echo -e "\e[0;34m$BinaryName Başlatıldı\033[0m"
sleep 2
echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
config
ge_ad_se_pe
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
echo -e "\e[0;34mNode Başlatıldı. Logları takip etmek için: \033[0;33m           sudo journalctl -u $BinaryName -fo cat\033[0m"
sleep 2
echo " "
sleep 2
source $HOME/.bash_profile
