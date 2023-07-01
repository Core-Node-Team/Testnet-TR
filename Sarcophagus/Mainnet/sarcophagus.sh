#!/bin/bash
clear
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/matrix.sh | bash
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/core-node.sh | bash
echo -e "\e[0;34mSarcophagus Kurulumu Başlatılıyor.\e[0m" && sleep 3
echo -e '\e[0;35m' && read -p "Cüzdanınızın Private Key girin: " PrivKey 
echo -e "\033[033mPrivate Key\033[034m $PrivKey \033[033molarak kaydedildi"
echo -e '\e[0m'
echo "export PrivKey=$PrivKey" >> $HOME/.bash_profile
sleep 1
echo -e '\e[0;35m' && read -p "Domain isminizi girin: " Domain 
echo -e "\033[033mDomain Name\033[034m $Domain \033[033molarak kaydedildi"
echo -e '\e[0m'
echo "export Domain=$Domain" >> $HOME/.bash_profile
sleep 1
RPCSEC=""
while [[ $RPCSEC != "1" && $RPCSEC != "2" && $RPCSEC != "3" && $RPCSEC != "4" ]]; do 
echo -e "\e[0;34mRPC URL seçiminizi yapın\033[0m"
echo -e "\e[0;33m"
sleep 1
echo -e "1-) https://rpc.ankr.com/eth"
echo -e "2-) https://eth.llamarpc.com"
echo -e "3-) https://ethereum.publicnode.com"
echo -e "4-) Özel"
echo -e "\033[0;35m"
read -p "Seçiminiz (1/2/3/4): " RPCSEC
echo -e '\e[0m'
done 
if [ $RPCSEC == "1" ]; then RPC="https://rpc.ankr.com/eth" && echo -e "\033[033mRpc Adresi\033[034m $RPC \033[033molarak kaydedildi" && echo "export RPC=$RPC" >> $HOME/.bash_profile
elif [ $RPCSEC == "2" ]; then RPC="https://eth.llamarpc.com" && echo -e "\033[033mRpc Adresi\033[034m $RPC \033[033molarak kaydedildi" && echo "export RPC=$RPC" >> $HOME/.bash_profile
elif [ $RPCSEC == "3" ]; then RPC="https://ethereum.publicnode.com" && echo -e "\033[033mRpc Adresi\033[034m $RPC \033[033molarak kaydedildi" && echo "export RPC=$RPC" >> $HOME/.bash_profile
elif [ $RPCSEC == "4" ]; then 
echo -e '\e[0;35m' && read -p "Özel Rpc Url Adresini Girin: " RPC 
echo -e "\033[033mRpc Adresi\033[034m $RPC \033[033molarak kaydedildi"
echo -e '\e[0m' && echo "export RPC=$RPC" >> $HOME/.bash_profile
fi
source $HOME/.bash_profile
sleep 1
echo -e "\e[0;34mSunucu Hazırlanıyor.\e[0m"
exec > /dev/null 2>&1 && docker stop quickstart-archaeologist-archaeologist-1 quickstart-archaeologist-acme-companion-1 nginx-proxy && docker rm quickstart-archaeologist-archaeologist-1 quickstart-archaeologist-acme-companion-1 nginx-proxy
cd $HOME && rm -rf quickstart-archaeologist && exec > /dev/tty 2>&1
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/preparing-server.sh | bash
curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/install-docker.sh | bash
echo -e "\e[0;34mQuickstart Archaeologist Kuruluyor.\e[0m" && exec > /dev/null 2>&1
git clone https://github.com/sarcophagus-org/quickstart-archaeologist && cd quickstart-archaeologist
cp .env.example .env
touch peer-id.json
Mnemonic=$(COMPOSE_PROFILES=seed docker compose run seed-gen | grep -oE "[a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+ [a-zA-Z]+")
echo "export Mnemonic=$Mnemonic" >> $HOME/.bash_profile
sed -i "s/^ETH_PRIVATE_KEY=.*/ETH_PRIVATE_KEY=${PrivKey}/" .env
sed -i "s/^DOMAIN=.*/DOMAIN=${Domain}/" .env
sed -i "s|^PROVIDER_URL=.*|PROVIDER_URL=${RPC}|" .env
sed -i "s/^ENCRYPTION_MNEMONIC=.*/ENCRYPTION_MNEMONIC=${Mnemonic}/" .env
cp .env /$HOME/env.backup
COMPOSE_PROFILES=service docker compose pull
exec > /dev/tty 2>&1
echo -e "\e[0;34mKurulum Tamamlandı.\e[0m"
sleep 1
echo -e "\e[0;32mArkeoloğunuzu kaydetmek için:\033[0;35m cd quickstart-archaeologist && COMPOSE_PROFILES=register docker compose run register\e[0;32m komutunu çalıştırın"
echo -e "\e[0;32mYönergeleri takip edin ardından başlatmak için:\033[0;35m COMPOSE_PROFILES=service docker compose up -d\e[0;32m komutunu çalıştırın"
echo -e '\e[0m'
source $HOME/.bash_profile
