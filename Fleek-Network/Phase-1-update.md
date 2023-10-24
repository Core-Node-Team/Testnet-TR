### Otocular tek kod
Not: su lgtn diyerek lgtn kullanıcısına geçip deneyin hata alırsanız
```
curl -sS https://get.fleek.network/update | bash
```
### Update Manuelciler

```
cd
cd ~/lightning
sudo systemctl stop lightning
```
```
git checkout testnet-alpha-1
```
```
git stash 
```
```
git pull origin testnet-alpha-1
```
```
git fetch origin testnet-alpha-1
git reset --hard origin/testnet-alpha-1
git clean -f
```
```
cargo +stable build --release
```
```
sudo rm -f "/usr/local/bin/lgtn"
sudo ln -s "$HOME/lightning/target/release/lightning-node" /usr/local/bin/lgtn
```
```
sudo systemctl daemon-reload
sudo systemctl enable lightning
sudo systemctl restart lightning
```
```
sudo systemctl status lightning.service
```
### Loglara bakalım
```
tail -f /var/log/lightning/output.log
```
### Dururmuna bakalım ( `running and stake` diyorsa tamamız )
```
curl -w "\p" localhost:4230/health
```









