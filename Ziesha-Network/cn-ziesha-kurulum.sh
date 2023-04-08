#!/bin/bash
clear
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
sleep 4
echo -e "\e[0;34mZiesha Kurulumu Başlatılıyor\033[0m"
echo -e ''
rm -rf .bazuka
rm -rf .bazuka.yaml
rm -rf .bazuka-wallet
rm -rf bazuka
sleep 2
echo -e '\e[0;35m' && read -p "Discord isminizi girin: " DISCORD 
echo -e "\033[035mDiscord isminiz\033[034m $DISCORD \033[035molarak kaydedildi"
echo -e '\e[0m'
echo -e ''
sleep 2
echo -e "\e[0;34mSunucu Güncelleniyor\033[0m"
echo -e ''
sleep 1
sudo apt-get update -y && sudo apt-get upgrade -y 
echo -e ''
sleep 1
echo -e "\e[0;34mKütüphaneler Kuruluyor\033[0m"
echo -e ''
sleep 1
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make cmake ncdu -y
echo -e ''
echo -e ''
echo -e "\e[0;34mRust Kurulumu\033[0m"
echo -e ''
echo -e ''
sleep 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
echo ""
echo ""
sleep 2
echo -e "\e[0;34mBazuka Kuruluyor"
echo ""
echo -e "\033[033mBazuka, Ziesha Network için düğüm ve cüzdan yazılımıdır.\e[0m" 
echo ""
echo ""
sleep 2
git clone https://github.com/ziesha-network/bazuka
source "$HOME/.cargo/env"
cd bazuka
git pull origin master
cargo update
cargo install --path .
source "$HOME/.cargo/env"
echo -e ""
echo -e ""
sleep 2
echo ""
echo -e "\033[0;34mBazuka Başlatılacak"
echo ""
sleep 2
echo -e "\e[0;32mCüzdan seçiminizi yapın\033[0m"
echo -e "\e[0;33m"
sleep 1
echo -e "1-) Eski cüzdanımı kullanmak istiyorum."
echo -e "2-) Yeni bir cüzdan oluştur."
echo -e "\033[0;35m"
read -p "Seçiminiz (1/2): " CUZDAN
echo ""
echo -e '\e[0m'

while [[ $CUZDAN != "1" && $CUZDAN != "2" ]];
 do 
 echo "\033[031mHatalı seçim yaptınız\033[0m"
 echo ""
 sleep 2
 echo -e "\e[0;32mCüzdan seçiminizi yapın\033[0m"
 sleep 1
 echo -e "\e[0;33m"
 echo -e "1-) Eski cüzdanımı kullanmak istiyorum."
 echo -e "2-) Yeni bir cüzdan oluştur."
 echo -e "\033[0;35m"
 read -p "Seçiminiz (1/2): " CUZDAN
 echo ""
 echo -e '\e[0m'
done 

if [ $CUZDAN == "1" ]; then
 sleep 1
 echo -e "\e[0;35m"
 read -p "Mnemonicleri girin: " MNEMONIC
 echo ""
 echo -e '\e[0m'
 sleep 2
 echo -e "\e[0;34mBazuka Başlatıldı.\033[0m"
 echo ""
 sleep 2
 bazuka init --network tahdig --external $(wget -qO- eth0.me):8765 --bootstrap 31.210.53.186:8765 --mnemonic "$MNEMONIC"
 sleep 3
  elif [ $CUZDAN == "2" ]; then
   sleep 1
   echo -e "\033[32mYeni cüzdan oluşturulacak.\033[0m"
   echo ""
   sleep 1
   echo -e "\e[0;34mBazuka Başlatıldı.\033[0m"
   echo ""
   sleep 1
   echo -e "    \033[031m+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
   echo -e "    Mnemoniclerinizi kaydetmeyi unutmayın!!!"
   echo -e "    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[0m"
   echo ""
   echo ""
   sleep 3
   bazuka init --network tahdig --external $(wget -qO- eth0.me):8765 --bootstrap 31.210.53.186:8765
   sleep 8
fi 

sudo tee /etc/systemd/system/bazuka.service > /dev/null <<EOF
[Unit]
Description=Bazuka
After=network.target
[Service]
User=root
ExecStart=/root/.cargo/bin/bazuka node start --discord-handle "$DISCORD"
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable bazuka
sudo systemctl start bazuka
echo -e ""
echo -e ""
echo -e "\e[0;34mNode başlatıldı.\e[0m"
echo -e ""
sleep 2
echo -e "\e[0;32mLogları Görüntülemek İçin:\033[0;35m  sudo journalctl -u bazuka -fo cat\e[0m"
echo -e ""
echo -e ""
sleep 3
echo -e "\e[0;34mKurulum Tamamlandı\e[0m"
echo -e ""
sleep 2
echo -e "\033[33m"
echo -e "  - İşlem yapmadan önce senkonize olmayı beklemelisiniz"
echo -e "  - Explorerdan nodenizi kontrol edin.  http://65.108.193.133:8000/"
echo -e "  - Güncellemeler için Discordu takip etmeyi unutmayın. Sorularınız olursa yine discorddan sorabilirsiniz"
sleep 2
echo -e ""
echo -e ""
echo -e ""
echo -e "\033[32m"

echo " ██████╗ ██████╗ ██████╗ ███████╗    ███╗   ██╗ ██████╗ ██████╗ ███████╗";
echo "██╔════╝██╔═══██╗██╔══██╗██╔════╝    ████╗  ██║██╔═══██╗██╔══██╗██╔════╝";
echo "██║     ██║   ██║██████╔╝█████╗      ██╔██╗ ██║██║   ██║██║  ██║█████╗  ";
echo "██║     ██║   ██║██╔══██╗██╔══╝      ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ";
echo "╚██████╗╚██████╔╝██║  ██║███████╗    ██║ ╚████║╚██████╔╝██████╔╝███████╗";
echo " ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝";
echo "                                                                        ";
echo -e "\033[31m            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
echo -e "\033[34m                https://twitter.com/corenodeHQ"
echo -e "                https://github.com/Core-Node-Team"
echo -e "                https://t.me/corenodechat"
echo -e "                https://discord.gg/fzzUAU9k"
echo -e "\033[31m            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
echo -e '\e[0m'
echo ""
sleep 3













