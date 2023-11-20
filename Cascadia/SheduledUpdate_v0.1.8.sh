#!/bin/bash
clear

HedefBlok="3400000"

update() {
echo "Düğüm belirtilen blok yüksekliğine ulaştı. Güncelleme yapılıyor..."
sudo systemctl stop cascadiad
cd $HOME && rm -rf cascadiad
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.8/cascadiad -o cascadiad
chmod +x cascadiad
sudo mv cascadiad $(which cascadiad)
sudo systemctl start cascadiad
}

curl -sSL https://raw.githubusercontent.com/0xSocrates/Scripts/main/core-node.sh | bash
echo -e ""
echo -e "Current Version: $(cascadiad version)"
echo -e "Update Version: 0.1.8"
echo -e "Update Height: $HedefBlok"
echo -e "Current Height: $(cascadiad status 2>&1 | jq -r .SyncInfo.latest_block_height)"
echo -e ""

while true; do
    latest_block_height=$(cascadiad status 2>&1 | jq -r .SyncInfo.latest_block_height)
    if [ "$latest_block_height" -ge "$HedefBlok" ]; then
        update  
        break
    else
        echo -e "Düğüm henüz beklenen blok yüksekliğine ulaşmadı($(cascadiad status 2>&1 | jq -r .SyncInfo.latest_block_height)) Bekleniyor..."
    fi
    sleep 10 
done





