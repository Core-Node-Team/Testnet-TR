#!/bin/bash
clear
curl -sSL https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Scripts/matrix.sh | bash
sleep 1
echo -e '\e[0;32m'
echo " ▄████████  ▄██████▄     ▄████████    ▄████████     ███▄▄▄▄    ▄██████▄  ████████▄     ▄████████ ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███▀▀▀██▄ ███    ███ ███   ▀███   ███    ███ ";
echo "███    █▀  ███    ███   ███    ███   ███    █▀      ███   ███ ███    ███ ███    ███   ███    █▀  ";
echo "███        ███    ███  ▄███▄▄▄▄██▀  ▄███▄▄▄         ███   ███ ███    ███ ███    ███  ▄███▄▄▄     ";
echo "███        ███    ███ ▀▀███▀▀▀▀▀   ▀▀███▀▀▀         ███   ███ ███    ███ ███    ███ ▀▀███▀▀▀     ";
echo "███    █▄  ███    ███ ▀███████████   ███    █▄      ███   ███ ███    ███ ███    ███   ███    █▄  ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███   ███ ███    ███ ███   ▄███   ███    ███ ";
echo "████████▀   ▀██████▀    ███    ███   ██████████      ▀█   █▀   ▀██████▀  ████████▀    ██████████ ";
echo "                        ███    ███                                                               ";
echo ""
echo -e '\e[0m' 
echo -e ''
echo -e ''
sleep 4
echo -e "\e[0;34mEmpower Kurulumu Başlatılıyor\033[0m"
echo -e ''
sleep 2
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo -e ''
exec > /dev/null 2>&1
cd /$HOME
rm -rf empowerchain
sudo rm -rf .empowerchain
sudo rm -rf /usr/local/bin/empowerd
sudo rm -rf /root/go/bin/empowerd
sudo rm -rf $(which empowerd)
exec > /dev/tty 2>&1
echo -e ''
sleep 1
echo -e "\e[0;34mSunucu Güncelleniyor\033[0m"
sleep 1
exec > /dev/null 2>&1
sudo apt-get update -y && sudo apt-get upgrade -y
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
sleep 1
echo -e "\e[0;34mKütüphaneler Kuruluyor\033[0m"
sleep 1
exec > /dev/null 2>&1
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
sleep 1
echo -e "\e[0;34mGo Yükleniyor\033[0m"
exec > /dev/null 2>&1
cd $HOME
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e "\e[0;33m$(go version) Kuruldu\033[0m"
echo -e ''
sleep 1
echo -e "\e[0;34mEmpowerchain Kuruluyor\033[0m"
sleep 1
exec > /dev/null 2>&1
cd /$HOME
git clone https://github.com/EmpowerPlastic/empowerchain.git
cd empowerchain/chain
git checkout v1.0.0-rc1
make install 
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e "\e[0;33mEmpowerd $(empowerd version) Kuruldu\033[0m"
sleep 1
echo -e ''
echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
sleep 1
exec > /dev/null 2>&1
empowerd config chain-id circulus-1
empowerd config keyring-backend test
empowerd config node tcp://localhost:15057
empowerd init $MONIKER --chain-id circulus-1
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Empower%20Chain/genesis.json > $HOME/.empowerchain/config/genesis.json
sleep 1
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Empower%20Chain/addrbook.json > $HOME/.empowerchain/config/addrbook.json
sleep 1
seeds="d6a7cd9fa2bafc0087cb606de1d6d71216695c25@51.159.161.174:26656"
peers="e8b3fa38a15c426e046dd42a41b8df65047e03d5@95.217.144.107:26656,89ea54a37cd5a641e44e0cee8426b8cc2c8e5dfb@51.159.141.221:26656,0747860035271d8f088106814a4d0781eb7b2bc7@142.132.203.60:27656,3c758d8e37748dc692621a0d59b454bacb69b501@65.108.224.156:26656,41b97fced48681273001692d3601cd4024ceba59@5.9.147.185:26656"
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.empowerchain/config/config.toml
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.025umpwr\"/" $HOME/.empowerchain/config/app.toml
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:15058\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:15057\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:15060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:15056\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":15066\"%" $HOME/.empowerchain/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:15017\"%; s%^address = \":8080\"%address = \":15080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:15090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:15091\"%; s%:8545%:15045%; s%:8546%:15046%; s%:6065%:15065%" $HOME/.empowerchain/config/app.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/.empowerchain/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/.empowerchain/config/config.toml
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.empowerchain/config/app.toml
sleep 1
sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.empowerchain/config/config.toml
exec > /dev/tty 2>&1
echo -e '\e[0;32m'
echo -e "İnitalize ✔"
sleep 1
echo -e "Min gas price ✔"
sleep 1
echo -e "Seeds ✔  Peers ✔"
sleep 1
echo -e "Genesis ✔  Addrbook ✔"
sleep 1
echo -e "Port ✔"
sleep 1
echo -e "Pruning ✔  İndexer ✔"
echo -e '\e[0m'
exec > /dev/null 2>&1
sudo systemctl stop empowerd
sudo systemctl disable empowerd
sudo rm -rf /etc/systemd/system/empowerd.service
sudo tee /etc/systemd/system/empowerd.service > /dev/null <<EOF
[Unit]
Description=EmpowerChain Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which empowerd) start --home $HOME/.empowerchain
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sleep 1
sudo systemctl daemon-reload
sudo systemctl enable empowerd
sudo systemctl start empowerd
sudo systemctl restart empowerd
exec > /dev/tty 2>&1
echo -e ' '
echo -e "\e[0;34mNode Başlatıldı\033[0m"
sleep 1
echo -e ""
echo -e "\e[0;32mLogları Görüntülemek İçin:\033[0;33m           sudo journalctl -u empowerd -fo cat\e[0m"
sleep 1
echo -e ""
echo -e ""
echo -e "\e[0;34mKurulum Tamamlandı\e[0m\u2600"
sleep 2 
echo -e ""
echo -e ""
echo -e '\e[0;32m'
echo " ▄████████  ▄██████▄     ▄████████    ▄████████     ███▄▄▄▄    ▄██████▄  ████████▄     ▄████████ ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███▀▀▀██▄ ███    ███ ███   ▀███   ███    ███ ";
echo "███    █▀  ███    ███   ███    ███   ███    █▀      ███   ███ ███    ███ ███    ███   ███    █▀  ";
echo "███        ███    ███  ▄███▄▄▄▄██▀  ▄███▄▄▄         ███   ███ ███    ███ ███    ███  ▄███▄▄▄     ";
echo "███        ███    ███ ▀▀███▀▀▀▀▀   ▀▀███▀▀▀         ███   ███ ███    ███ ███    ███ ▀▀███▀▀▀     ";
echo "███    █▄  ███    ███ ▀███████████   ███    █▄      ███   ███ ███    ███ ███    ███   ███    █▄  ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███   ███ ███    ███ ███   ▄███   ███    ███ ";
echo "████████▀   ▀██████▀    ███    ███   ██████████      ▀█   █▀   ▀██████▀  ████████▀    ██████████ ";
echo "                        ███    ███                                                               ";
echo ""
echo -e ""
echo -e '\e[0m' 
sleep 3
curl -sSL https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Scripts/y%C4%B1ld%C4%B1z.sh | bash
sleep 1
