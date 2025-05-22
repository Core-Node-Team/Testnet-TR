




```
systemctl stop story
systemctl stop geth
```
```
rm -rf $HOME/story-geth
git clone https://github.com/piplabs/story-geth.git
cd story-geth
git checkout v1.1.0
go build -v ./cmd/geth
mv ./geth $HOME/go/bin/story-geth
```
```
systemctl start story
systemctl start geth
```
