### Aeneid Testnet at block height 4,362,990, estimated to arrive on May 13, UTC.
```
systemctl stop story
cd $HOME
wget https://github.com/piplabs/story/releases/download/v1.2.0/story-linux-amd64
sudo chmod +x story-linux-amd64
sudo mv ./story-linux-amd64 $HOME/go/bin/story
source $HOME/.bashrc
story version
```
```
systemctl restart story
```
```
journalctl -u story -f -o cat
```
