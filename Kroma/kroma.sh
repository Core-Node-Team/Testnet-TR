#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://raw.githubusercontent.com/molla202/Scripts/main/molla202.sh | bash && sleep 1
if ss -tulpen | awk '{print $5}' | grep -q ":7300$" ; then
	echo -e "\e[31mInstallation is not possible, port 7300 already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9003$" ; then
	echo -e "\e[31mInstallation is not possible, port 9003 already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9545$" ; then
	echo -e "\e[31mInstallation is not possible, port 9545 already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8545$" ; then
	echo -e "\e[31mInstallation is not possible, port 8545 already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8546$" ; then
	echo -e "\e[31mInstallation is not possible, port 8546 already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8551$" ; then
	echo -e "\e[31mInstallation is not possible, port 8551 already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":30304-$" ; then
	echo -e "\e[31mInstallation is not possible, port 30304- already in use.\e[39m"
	exit
fi
if ss -tulpen | awk '{print $5}' | grep -q ":30303-$" ; then
	echo -e "\e[31mInstallation is not possible, port 30303- already in use.\e[39m"
	exit
fi
read -p "Paste your ETH_PRIVATE_KEY: " PRIVATE_KEY
read -p "Paste your Ethereum Sepolia RPC URL(EXAMPLE, DO NOT COPY: https://eth-sepolia.g.alchemy.com/v2/corenode.info): " SEPOLIA_RPC_URL

sudo apt update
sudo apt install git ca-certificates curl gnupg unzip wget -y
#install docker
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
sudo install -m 0755 -d /etc/apt/keyrings
sudo rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#install docker-compose
sudo apt install docker-compose-plugin -y

cd $HOME && mv kroma-up kroma-up_$(date +%s) 2>/dev/null
git clone https://github.com/kroma-network/kroma-up.git
#sudo chmod -R a+rwx kroma-up
cd kroma-up && ./startup.sh
sed -i.bak s/KROMA_VALIDATOR__PRIVATE_KEY=.*/KROMA_VALIDATOR__PRIVATE_KEY=$PRIVATE_KEY/ $HOME/kroma-up/.env
sed -i s^L1_RPC_ENDPOINT=.*^L1_RPC_ENDPOINT=$SEPOLIA_RPC_URL^g $HOME/kroma-up/.env
#Start the Validator Node
sudo docker compose --profile validator up -d
./sync_block.sh
sleep 2
echo -e "Your Kroma node \e[32mKuruldu Ve Calısıyor\e[39m!"
