<h1 align="center"> Story Test </h1>

![image](https://github.com/user-attachments/assets/18a1eb57-1fd5-41f4-8645-2d7cd4e1477c)


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
cd story-geth
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
PEERS="45938d3dfe2877e1eb45cbce10f2d02c676f50a0@198.244.176.117:32656,e894f1fb01b866b0e6edeb827c52031ecb67f8a0@117.20.40.91:26656,59201fade719c1e4ded98b2304e555377d2b4cef@116.202.217.20:28656,5c46a4c8acd563deb9008d3cf5dceb1e05b6b534@35.211.180.163:26656,ce61393efc60bb67020a2d989a09164334adc62e@35.211.77.198:26656,155bcba7d521ced31042bd99100841c6cf057f36@35.211.9.151:26656,1ff566a5ac0bd3605e8af09e92cacc43927aed7f@161.35.70.64:26656,580be4f3e5f505ed0ea15510997aeeb74e35408e@35.211.167.181:26656,1fa4f7c1d32aa695a0d6c83b5960421e6b2bc981@95.217.119.251:26656,0eda723784a874798b173df8f17545f9984b86e6@35.211.230.141:26656,2a28bd1a6ecb0a1d8ceade599b311d202447d635@193.122.141.78:26656,2e00c3e558f382e48fe7511f50c069fde44a6468@150.136.128.196:26656,1851180d526f7a4cfc5e391263869ba9d24bb8e7@35.207.39.228:26656,36ca8b119bf5851cd1e37060af914cb07dec24f9@34.79.40.193:26656,2bd1c71a630e7a6d3edd48bb99c90384bc68e801@83.125.137.146:26656,944e8889ecd7c13623ef1081aae4555d6f525041@35.211.57.203:26656,7ed3ba377ca3b31b54b85564bb14474f665fa0b8@54.82.200.23:26656,004e5fcf5f32d3dc052cf0de2a31d91da380f2a1@188.40.66.173:29256,817a54d7ed4f3b618d37ea80448c135b20fc34e1@34.143.143.252:26656,7e311e22cff1a0d39c3758e342fa4c2ee1aea461@188.166.224.194:28656,3b1aaa03f996d619cb2f4230ebace45686ab3b8a@34.140.167.127:26656,b965eed902107d29df3669b2ff9a93859db236a3@49.12.92.82:56356,9eae7b3b91072c6efc1aa4f537237e3feb0a0cc7@129.80.220.65:26656,20a1a828469c42047601529a50f527ecf9301251@35.211.53.224:26656,6c89fb9e0791ffa67468b9f9923891a2bfcad80f@141.94.143.203:56356,3ac43df99e694888d36eae59668ff8d00c440ee7@34.136.120.228:26656,d647f60a09bbd309566a6342aa61b4c5b362568f@167.235.178.134:29256,78428011f9855eac7f87c868163b9edebf789c1c@46.4.80.48:29456,b540a4a88399bee252207ab9cf783c14fcefd4dc@65.108.30.59:26656,f28f9d1c4afedaba0d277ee457be64ef3a6c4955@54.90.79.21:26656,fd766c875975ee889124ba7363bad99d211d72ce@54.148.75.218:26656,b21b772ca2e4067844f881e8a79a7447dc435217@65.108.141.109:29456"
sed -i -e "/^\[p2p\]/,/^\[/{s/^[[:space:]]*persistent_peers *=.*/persistent_peers = \"$PEERS\"/}" $HOME/.story/story/config/config.toml
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



























