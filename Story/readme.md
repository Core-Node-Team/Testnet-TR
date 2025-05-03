<h1 align="center"> Story Test </h1>



 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>


## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	8|
| RAM	| 32+ GB |
| Storage	| 400 GB SSD |




### 🚧Gerekli kurulumlar
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
sudo apt install -y \
  curl \
  git \
  make \
  jq \
  build-essential \
  gcc \
  unzip \
  wget \
  lz4 \
  aria2 \
  gh
```

### 🚧Go kurulumu
```
cd $HOME
VER="1.22.0"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```

```
cd $HOME
wget https://github.com/piplabs/story-geth/releases/download/v1.0.2/geth-linux-amd64
sudo mv ./geth-linux-amd64 story-geth
sudo chmod +x story-geth
sudo mv ./story-geth $HOME/go/bin/
source $HOME/.bashrc
```
NOT: yukarıdaki ubuntu 24 için aşağıdan build edin daha dusuk surumde ubuntunuz varsa
```
git colone https://github.com/piplabs/story-geth.git
go build -v ./cmd/geth
mv ./geth $HOME/go/bin/story-geth
```
```
story-geth version
```


```
sudo tee /etc/systemd/system/story-geth.service > /dev/null <<EOF
[Unit]
Description=Story Geth Client
After=network.target

[Service]
User=${user}
ExecStart=$(which story-geth) --aeneid --syncmode full
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF
```
#### Start service
```
sudo systemctl daemon-reload
sudo systemctl enable story-geth
sudo systemctl restart story-geth
```
```
sudo systemctl status story-geth
```
```
journalctl -u story-geth -f -o cat
```

### Story
```
cd $HOME
wget https://github.com/piplabs/story/releases/download/v1.2.0/story-linux-amd64
sudo mv story-linux-amd64 story
sudo chmod +x story
sudo mv ./story $HOME/go/bin/
source $HOME/.bashrc
story version
```

```
story init --network aeneid --moniker corenode
```

```
sudo tee /etc/systemd/system/story.service > /dev/null <<EOF
[Unit]
Description=Story
After=network.target

[Service]
Type=simple
User=${USER}
Group=${GROUP}
ExecStart=$(which story) run
Restart=on-failure
RestartSec=5s
LimitNOFILE=65535
WorkingDirectory=$HOME/.story/story

[Install]
WantedBy=multi-user.target
EOF
```

```
sudo systemctl daemon-reload
sudo systemctl enable story
sudo systemctl restart story
```
```
journalctl -u story -f -o cat
```



























