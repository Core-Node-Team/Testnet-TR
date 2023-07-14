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
corenodecascadia() {
echo -e "\e[0;34mCascadia Kurulumu Başlatılıyor\033[0m"
echo -e ''
sleep 2
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
echo -e ''
exec > /dev/null 2>&1
cd /$HOME
rm -rf cascadia
sudo rm -rf .cascadiad
sudo rm -rf /usr/local/bin/cascadiad
sudo rm -rf /root/go/bin/cascadiad
sudo rm -rf $(which cascadiad)
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
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && source $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
echo -e "\e[0;33m$(go version) Kuruldu\033[0m"
echo -e ''
sleep 1
echo -e "\e[0;34mCascadia Kuruluyor\033[0m"
sleep 1
exec > /dev/null 2>&1
cd /$HOME
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.3/cascadiad-v0.1.3-linux-amd64 -o cascadiad
chmod +x cascadiad
sudo cp cascadiad /usr/local/bin/cascadiad
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
echo -e "\e[0;33mCascadiad $(cascadiad version) Kuruldu\033[0m"
sleep 1
echo -e ''
exec > /dev/null 2>&1
cascadiad config chain-id cascadia_6102-1
cascadiad config keyring-backend test
cascadiad config node tcp://localhost:11957
cascadiad init $MONIKER --chain-id cascadia_6102-1
sleep 2
exec > /dev/tty 2>&1
echo -e ''
echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
sleep 1
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Cascadia/addrbook.json > $HOME/.cascadiad/config/addrbook.json
sleep 1
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Cascadia/genesis.json > $HOME/.cascadiad/config/genesis.json
sleep 1
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025aCC\"/" ~/.cascadiad/config/app.toml
peers="001933f36a6ec7c45b3c4cef073d0372daa5344d@194.163.155.84:49656,f78611ffa950efd9ddb4ed8f7bd8327c289ba377@65.109.108.150:46656,783a3f911d98ad2eee043721a2cf47a253f58ea1@65.108.108.52:33656,6c25f7075eddb697cb55a53a73e2f686d58b3f76@161.97.128.243:27656,8757ec250851234487f04466adacd3b1d37375f2@65.108.206.118:61556,df3cd1c84b2caa56f044ac19cf0267a44f2e87da@51.79.27.11:26656,d5519e378247dfb61dfe90652d1fe3e2b3005a5b@65.109.68.190:55656,f075e82ca89acfbbd8ef845c95bd3d50574904f5@159.69.110.238:36656,63cf1e7583eabf365856027815bc1491f2bc7939@65.108.2.41:60556,d5ba7a2288ed176ae2e73d9ae3c0edffec3caed5@65.21.134.202:16756"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.cascadiad/config/config.toml
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:11958\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:11957\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:11960\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:11956\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":11966\"%" $HOME/.cascadiad/config/config.toml
sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://localhost:11917\"%; s%^address = \":8080\"%address = \":11980\"%; s%^address = \"localhost:9090\"%address = \"localhost:11990\"%; s%^address = \"localhost:9091\"%address = \"localhost:11991\"%; s%:8545%:11945%; s%:8546%:11946%; s%:6065%:11965%" $HOME/.cascadiad/config/app.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 50/g' $HOME/.cascadiad/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 50/g' $HOME/.cascadiad/config/config.toml
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/.cascadiad/config/app.toml
sleep 1
sed -i -e 's|^indexer *=.*|indexer = "null"|' $HOME/.cascadiad/config/config.toml
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
sudo systemctl stop cascadiad
sudo systemctl disable cascadiad
sudo rm -rf /etc/systemd/system/cascadiad.service
sudo tee /etc/systemd/system/cascadiad.service > /dev/null <<EOF
[Unit]
Description=Cascadia Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which cascadiad) start --home $HOME/.cascadiad
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sleep 1
sudo systemctl daemon-reload
sudo systemctl enable cascadiad
sudo systemctl start cascadiad
sudo systemctl restart cascadiad
sleep 2
source $HOME/.bash_profile
sudo systemctl restart cascadiad
exec > /dev/tty 2>&1
echo -e ' '
echo -e "\e[0;34mNode Başlatıldı\033[0m"
sleep 1
echo -e ""
echo -e "\e[0;32mLogları Görüntülemek İçin:\033[0;33m           sudo journalctl -u cascadiad -fo cat\e[0m"
echo -e ""
echo -e ""
sleep 1
echo -e "\e[0;34mKurulum Tamamlandı\e[0m\u2600"
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
echo -e ""
echo -e '\e[0m' 
echo -e ''
echo -e ''
sleep 3
curl -sSL https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Scripts/y%C4%B1ld%C4%B1z.sh | bash
sleep 1
source $HOME/.bash_profile
}
corenodecascadia

source $HOME/.bash_profile

