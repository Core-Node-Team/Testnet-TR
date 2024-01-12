#!/bin/bash
clear
BinaryName="babylond"
DirectName=".babylond" #database directory
CustomPort="311"
NodeName="babylon"  # project folder
ChainID="bbn-test-2"
install_binary() {
exec > /dev/null 2>&1

sudo apt install -y curl git jq lz4 build-essential unzip

ver="1.21.5"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

git clone https://github.com/babylonchain/babylon.git
cd babylon
git checkout v0.7.2
make install
exec > /dev/tty 2>&1
}
ge_ad_se_pe() {
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/addrbook.json > $HOME/$DirectName/config/addrbook.json
curl -Ls https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Babylon/genesis.json > $HOME/$DirectName/config/genesis.json
peers="603f5e1d2b796e125265b975135e1780e080e8fd@138.201.204.5:37656,07d1b69e4dc56d46dabe8f5eb277fcde0c6c9d1e@23.88.5.169:17656,0a0d7d245ea67cfeec7d000085260fbe695544f4@207.180.251.220:11656,924632d809935a2ba6035df0dd3a787dde7b788c@144.76.201.43:26356,1016bb6d890ffafe49eb8b2264937bdbcd775135@46.4.5.45:20656,4c4a3cffbbad5e12c2f4d1ee85f6a94eb271ae21@65.109.90.171:32656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:16456,37896797924b1cb18bce9b9542ba3da915a85038@18.218.71.198:26656,ec92965f98006978a470642a9e02f971fb4a70c6@18.119.146.153:26656,0de44b3d4380004838d38797a1aee10392b68420@3.18.176.128:26656"
seeds=""
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/$DirectName/config/config.toml
PEERS="123929fdd6543f82dfff28ca65f3b9cfb270f263@89.163.129.252:16456,a3c09a07b86de7cfaaf3d6c8c72f17c907dbc1d9@89.116.26.45:16456,a34f6e8692f0aa1cefdadc079a0d7c72c641b286@109.228.160.58:16456,e1393da5f12846cbc45a222ff80f4f5ac6359a6f@173.249.25.249:16456,9e229fb23617e6d1fc8f7a1c7b5120f39fe82d00@84.46.255.220:16456,624c44384b25e193989e7e8c6d9dc562b7735e50@154.26.128.108:16456,a3754e66d04ed81fc4da98c18bd3aeabc0c1394e@161.97.74.8:16456,022c802084b1faf2138f9076fe7dd29540a97ffb@144.91.110.78:16456,f55669d08fbfdeb6ccae5a5537687668a39481f6@188.119.112.135:16456,7907142fa13feecb5d10efeabf38467657e93668@213.202.216.196:16456,c9e8aa4e57116afbe80915621624b738949e0309@158.220.109.204:16456,59c88a4e4f39b68424e5d2f463dd9667392efd7c@185.194.217.231:16456,2359240b99824284c1c89d2b4ba7770a7212e50f@207.180.235.178:16456,a246886a74308e2cfc1b403c31f6f87a5a7992a0@46.250.240.29:16456,a45344a36fa02187ddb6f3741e3c8425a19d07ba@62.171.186.40:31156,a067eb05e2df8ccc2ba99039047b98bc31399a9a@5.78.69.113:3156,14e5a49a76d58d2ad63a4f70dbcf0f726ac529d1@65.21.107.96:16456,08cbf2178193f6165cbec2053f7f00017520c380@173.249.47.22:16456,d488d73c6b5c2dcc0294ce1c2a75f882251bce04@65.108.60.230:16456,5c54fec9dff6f81f83bb7753ce18e43c7dc95b24@194.163.173.173:16456,87f942596810d8b2f8a86470caef0d7855813f89@65.109.48.247:09656,264bd9d69ff069f1cf3a687336c5da30b9ad6333@38.242.242.46:16456,beddbcd4a78adef0e6adc5e6cc445cb601608706@155.133.27.150:16456,3cacc1043c68467339b0212621c9888cee77623a@104.251.222.122:16456,8b4cde234f671d5263b996704e5926cc122d18bc@185.135.137.24:16456,5957d28e620a04cbafb8b506d96736f3a8ce53b0@165.232.82.210:31156,343da9ef02d2e6c96001f902b260bdb634d14ddc@149.102.159.15:16456,2b9a417d83bf21b26415a228250597a1be865787@144.91.79.231:16456,d8ad9421acea49336c5f460ff0e89975fe5ffb1a@194.163.134.227:31156,af3b4159b459ee544dca7e7a52eb55539ffb4732@143.42.68.147:26656,cd72d570c728aeb8cfd0679eaa9e8dd2a41474e5@62.171.144.128:26656,410f08405a102aa660af2ee0d06ab065111b7ce9@38.242.237.5:31156,8af526c37c4892745038d8016ec44056b1a70725@3.22.8.141:26656,06ae21da81c0bec51a1aa9e91e2dcc9a696eaea2@62.171.173.131:16456,036887985bac48574e29d90a9c5e235630a66e70@89.116.29.84:26656,a98484ac9cb8235bd6a65cdf7648107e3d14dab4@116.202.231.58:16456,6c564cf63e0835a559ed4df9ee1ea79536abd1a9@45.85.147.23:26656,868730197ee267db3c772414ec1cd2085cc036d4@148.251.235.130:17656,21af6c66c8ab043e0d9b35bcbeb3ed7b12e96232@168.119.77.61:16456,6aa2fa186f42295b43318344239a40fd29fda451@85.190.254.191:16456,c627530036f7178c8f6bd155ba8da1d64120fb70@185.216.75.112:16456,79fab4c80baaaae785c39b287a6a678ea7dbaa02@194.180.176.180:16456,6ad120cbb54cc02f0fc4c3ed46755979b2df42f4@149.102.132.207:31656,13a72973dfe3ce0eec18f50c63c81411f094f270@161.97.112.48:16456,4c9c7b18d86b464cd03fd87dc1a240c74fed1730@38.242.244.202:16456,3774fb9996de16c2f2280cb2d938db7af88d50be@162.62.52.147:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.babylond/config/config.toml
# min gas price
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.00001ubbn\"|" $HOME/.babylond/config/app.toml
exec > /dev/tty 2>&1
}
snapshot() {
exec > /dev/null 2>&1
sudo apt install liblz4-tool -y
exec > /dev/tty 2>&1
echo -e "\e[0;34mCore Node Chain Services Snapshot İndiriliyor\033[0m"
curl -L http://37.120.189.81/babylon_testnet/babylon_snap.tar.lz4 | tar -I lz4 -xf - -C $HOME/.babylond
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
