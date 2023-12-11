#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/0xSocrates/Scripts/main/style.sh)
clear
BinaryName="cascadiad"
DirectName=".cascadiad" #database directory
CustomPort="119"
NodeName="cascadia"  # project folder
ChainID="cascadia_11029-1"
install_binary() {
print_color $Blue "$BinaryName Kuruluyor..."
sleep 1
exec > /dev/null 2>&1
cd $HOME || return
rm -rf $HOME/cascadia
git clone https://github.com/cascadiafoundation/cascadia.git
cd $HOME/cascadia || return
git checkout v0.1.9
make install
exec > /dev/tty 2>&1
print_color $Yellow "$BinaryName $($BinaryName version) Kuruldu."
}
config() {
print_color $Blue "Yapılandırma Dosyası Ayarları Yapılıyor..."
exec > /dev/null 2>&1
#genesis
curl -s https://raw.githubusercontent.com/molla202/Cascadia-11029-devnet/main/genesis.json > $HOME/.cascadiad/config/genesis.json
#addrbook
curl -s https://raw.githubusercontent.com/molla202/Cascadia-11029-devnet/main/addrbook.json > $HOME/.cascadiad/config/addrbook.json
#set,seed-peers
SEEDS=""
PEERS="21ca2712116138429aed3d72422379397c53fa86@65.109.65.248:34656"
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.cascadiad/config/config.toml

# add min-gas prices command

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
print_color $Yellow "Tamamlandı."
}

snapshot() {
print_color $Blue "Core Node Chain Services Snapshot İndiriliyor..."
sleep 1
URL=https://snapshots-testnet.stake-town.com/cascadia/cascadia_11029-1_latest.tar.lz4
curl -L $URL | lz4 -dc - | tar -xf - -C $HOME/.cascadiad
}
init() {
$BinaryName config chain-id $ChainID
$BinaryName config keyring-backend test
$BinaryName config node tcp://localhost:${CustomPort}57
$BinaryName init $MONIKER --chain-id $ChainID
print_color $Yellow "$BinaryName Başlatıldı."
}




get_moniker () {
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER && echo -e '\e[0m' && echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 1
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
print_color $Blue "$NodeName Kurulumu Başlatılıyor..."
sleep 2
echo " "
get_moniker
removenode
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/preparing-server.sh | bash
install_binary
init
config
snapshot
exec > /dev/null 2>&1
sudo tee /etc/systemd/system/$BinaryName.service > /dev/null <<EOF
[Unit]
Description=$NodeName Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which $BinaryName) start --home $HOME/$DirectName --chain-id $ChainID
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable $BinaryName
systemctl start $BinaryName
systemctl restart $BinaryName
exec > /dev/tty 2>&1
echo -e "${Green}Node Başlatıldı. Logları Görüntülemek İçin:${Yellow}           sudo journalctl -u $BinaryName -fo cat ${NC}"
sleep 2
echo " "
source $HOME/.bash_profile
