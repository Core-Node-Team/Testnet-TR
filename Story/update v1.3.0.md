

```
cd ~
rm -rf story
git clone https://github.com/piplabs/story.git
cd story
git checkout v1.3.0
```
```
mkdir -p build/bin
go build -o build/bin/story ./client
```
```
sudo systemctl stop story
```
```
sudo cp build/bin/story $HOME/go/bin/
sudo chmod +x $HOME/go/bin/story
story version
```
```
sudo systemctl start story
```
