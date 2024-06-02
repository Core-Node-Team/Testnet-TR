### CrossFi Testnet'te 3.520.000 blokta büyük bir güncellemenin yayınlanması planlanıyor! Bu güncelleme 3 Haziran 2024 Pazartesi günü yaklaşık 11:30 UTC'de gerçekleşecektir
```
cd $HOME
wget http://37.120.189.81/crossfi_testnet/crossfid && chmod +x crossfid
```
```
mkdir -p $HOME/.mineplex-chain/cosmovisor/upgrades/v0.3.0-prebuild9/bin
mv crossfid $HOME/.mineplex-chain/cosmovisor/upgrades/v0.3.0-prebuild9/bin/
```
```
sudo systemctl restart crossfid && sudo journalctl -u crossfid -fo cat
```
