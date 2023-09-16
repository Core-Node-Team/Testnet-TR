## Blok yükseliği  2645000 geldiğinde yapacağız.

### Cosmovisor upgrade
```
cd $HOME
rm -rf elys
git clone https://github.com/elys-network/elys.git
cd elys
git checkout v0.11.0


make build


mkdir -p $HOME/.elys/cosmovisor/upgrades/v0.11.0/bin
mv build/elysd $HOME/.elys/cosmovisor/upgrades/v0.11.0/bin/
rm -rf build
```
## GO kurmamız gerekiyor atlamayın
```
cd $HOME
version="1.20.4"
wget "https://golang.org/dl/go$version.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$version.linux-amd64.tar.gz"
rm "go$version.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
systemctl stop elysd
cd $HOME/elys
git fetch --all
git checkout v0.11.0
make build
sudo mv $HOME/elys/build/elysd $(which elysd)
sudo systemctl restart elysd && sudo journalctl -u elysd -f
```

## Ardından snap atıyoruz..
```
sudo systemctl stop elysd

cp $HOME/.elys/data/priv_validator_state.json $HOME/.elys/priv_validator_state.json.backup

rm -rf $HOME/.elys/data 
curl https://testnet-files.itrocket.net/elys/snap_elys.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.elys

mv $HOME/.elys/priv_validator_state.json.backup $HOME/.elys/data/priv_validator_state.json
```
```
sudo systemctl restart elysd && sudo journalctl -u elysd -f
```
