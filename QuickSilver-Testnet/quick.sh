#!/bin/bash
clear
BinaryName="quicksilverd"
DirectName=".quicksilverd" #database directory
CustomPort="111"
NodeName="quicksilver"  # project folder
ChainID="rhye-1"
install_binary() {
exec > /dev/null 2>&1
cd $HOME
rm -rf ~/quicksilver
git clone https://github.com/ingenuity-build/quicksilver
cd quicksilver
git fetch
git checkout v1.4.4-rc.3
make install
exec > /dev/tty 2>&1
}
ge_ad_se_pe() {
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Testnet/addrbook.json > $HOME/$DirectName/config/addrbook.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/QuickSilver-Testnet/genesis.json > $HOME/$DirectName/config/genesis.json
SEEDS="78283975c2bee9b95bbf9408cc974cbab7bfe8ef@quicksilver-testnet-seed.itrocket.net:37656"
PEERS="2aed12a25bfa92e40ccb95c88692735a9488a17e@quicksilver-testnet-peer.itrocket.net:37656,9e191d79427b0cda187a923aba1847fd5f811795@65.108.203.149:57411,8b486ec6ee6167985f6eed69817f2a04bd70bba9@65.109.61.113:22217,cc18d980216d658b76112fefd49cf2bf03d2d1cb@65.109.58.237:36589,1d5a1818a6c4158daeae8bb1374511e79c6d3b5c@65.21.200.161:11656,60509a87fc6c97a013de3cdeadf5fd3eab22f896@65.109.23.114:11156,bd4957d43b74ae9f6dd55e219cb4db21edacd86d@65.108.192.123:21656,4657f913d7415096850731450198c2b044a26866@5.22.223.252:26656,3804efa70b33fd6d06f963ca1be1338796082bcf@51.89.9.82:26656,7f0596f0bcf4fa3b5dc7eae3c3233c62a13c438e@135.125.5.29:48656,a51e9a4a099716f29c901f49668a312ca9e49a5c@167.235.17.63:26656,6923a7eb5ddf93b68314fb3bbfbdff34f2b66cab@88.99.213.25:11156,c02431ff1a4fe66dca2d3c8ccbbd51b9977d8c54@88.208.57.200:11156,0587ab2f60f3f1f8a6cae4397d4b1f16db05656d@45.85.147.96:26656,1bea687fdcde91698f654977540fb8814bcf05c6@212.23.222.220:26456,8a334ed2e728ca1164f8ef6ae58dd5fda31da5be@190.2.146.152:28656,0265044736c3b59fb4982f3650cadebe457df561@167.86.99.7:16656,c3819ce50237e206e0c83eb1702423e85f9270ed@5.161.145.173:26656,8e14e58b054248a04be96e4a40d6359e93b636ac@65.108.65.94:26656,e6bf55bc9f08958b7518bea455423375db78d1ef@65.108.13.176:26656,5a3c424c19d9ab694190a7805a2b1a146460d752@65.108.2.27:26656,17574de80eeda21ae1ed94e162ad55b58914c6fa@135.181.210.171:20026,a98484ac9cb8235bd6a65cdf7648107e3d14dab4@116.202.231.58:11156,a52b512306fe33be0f20226f8f62240effe43d33@46.17.103.199:26656,29debee3d981638a4e81312e57249083d8abe42f@157.90.176.184:16656,760a6069c28f0b54548a656518471ca2b60481c6@135.181.133.249:16656,392a7ec2683e288866c353b7a8ac9ecc4e7b4bfc@142.165.207.45:16656,532625a997a6f891405202968607f72afe004f15@202.61.225.157:26666,22af97fb31a44b39cd8187ed4379c6b3ebd4b0ca@89.38.98.200:21026"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.quicksilverd/config/config.toml
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
