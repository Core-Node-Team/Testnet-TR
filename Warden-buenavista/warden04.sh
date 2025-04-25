#!/bin/bash

# Hedef block yüksekliği
TARGET_BLOCK=1534501

while true; do
    # Local node block yüksekliğini al
    local_height=$(curl -s localhost:11257/status | jq -r .result.sync_info.latest_block_height)

    # Mevcut block yüksekliğini ekrana yazdır
    echo "Your node height: $local_height"

    # Hedef block yüksekliğine ulaşıldı mı kontrol et
    if [ "$local_height" -ge "$TARGET_BLOCK" ]; then
        echo "Target block height reached. Updating app.toml and restarting services."

        # app.toml dosyasını güncelle
        wget -O $HOME/.warden/config/app.toml "https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Warden-buenavista/app.toml"


        # wardend servisini yeniden başlat
        systemctl daemon-reload && sudo systemctl restart wardend && sudo systemctl restart slinkyd


        # TMUX oturumunu kapat
        tmux kill-session -t slinkycheck
        break
    fi

    # 15 sn bekle
    sleep 15
done
