
![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/4f123c17-24f4-4137-a047-b45041814b49)

🔥 [CoreNode Telegram](https://t.me/corenode)

🔥 [CoreNode Twitter](https://twitter.com/corenodehq)


💬 Sorularınız için yukarıdaki adreslerden ulaşabilirsiniz.

#### 💬 Ne işe yarar ? Güncel olarak cosmos projelerinizde node bilgilerinizi destaylı görmeye ve api aracılığı ile uyarı almanızı sağlayan bir sistemdir.

### 🚧Update ve gereklilikler
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential git wget jq make gcc tmux pkg-config libssl-dev libleveldb-dev tar -y
```
### 🚧Go kurulumu
```
ver="1.21.5"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile
go version
```
### 🚧Port işlemleri ( normalde açmanıza gerek yok ancak port açmadan açılmayan firmalardan kullanıyorsanız gerekebilir. öncelikle atlayıp deneyin olmassa girin- eğer ssh bağlantısı için 22 den farklı bir port kullanıyorsanız onuda açmanız gerekir)
```
sudo apt install ufw 
sudo ufw default allow outgoing 
sudo ufw default deny incoming 
sudo ufw allow ssh/tcp 
sudo ufw limit ssh/tcp 
sudo ufw allow 22,26656,26660,8888/tcp
sudo ufw enable
```
### 🚧Tenderduty indirip kuralım
```
cd $HOME
rm -rf tenderduty
git clone https://github.com/blockpane/tenderduty
cd tenderduty
go install
cp example-config.yml config.yml
```
### 🚧config.yml düzenleyelim
👉Not: burda tek bir node için bilgiler var sunucuda extra validator varsa eklemek için syafanın sonuna alttaki extra kodunu ekleyip duzenlemek gerekiyor. proje adı ağ adı validator adresi ve port bilgileri giriyoruz. cosmoslarda genel olarak sonu 7 ile biten portunu yazıcaz projenin. portları öğrenmek için `sudo lsof -i -P -n | grep LISTEN` bu kodu girin proje ismini bulun sonu 7 ile biten o projenin portunu yazın
```
sudo nano $HOME/tenderduty/config.yml
```

- Osmosis : proje adını yazın
- chain_id: osmosis-1 ağ adını yazın. ( kurulumda yada kullandığın genel kodlarda ağ adı yazar)
- valoper_address: osmovaloper1xxxxxxx... dokumanalrdan kodlar ile yada daha basitçe explrerden validatorunuzetıklayınca operator adresi oalrak yazar valoperli
- tcp://localhost:26657 burdanda port numarasını değiştiriyoruz sadece


![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/2ff796e1-58a7-4ebb-a3d9-a3dfcb709332)

![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/213fe521-fb04-4992-bfb3-cdeb27150127)



### 🚧Extra Eklemek yapmak için
```
chains:

  # The user-friendly name that will be used for labels. Highly suggest wrapping in quotes.
  "Osmosis":
    # chain_id is validated for a match when connecting to an RPC endpoint, also used as a label in several places.
    chain_id: osmosis-1
    # Hooray, in v2 we derive the valcons from abci queries so you don't have to jump through hoops to figure out how
    # to convert ed25519 keys to the appropriate bech32 address
    valoper_address: osmovaloper1xxxxxxx...
    # Should the monitor revert to using public API endpoints if all supplied RCP nodes fail?
    # This isn't always reliable, not all public nodes have websocket proxying setup correctly.
    public_fallback: no

    # Controls various alert settings for each chain.
    alerts:
      # If the chain stops seeing new blocks, should an alert be sent?
      stalled_enabled: yes
      # How long a halted chain takes in minutes to generate an alarm
      stalled_minutes: 10

      # Most basic alarm, you just missed x blocks ... would you like to know?
      consecutive_enabled: yes
      # How many missed blocks should trigger a notification?
      consecutive_missed: 5
      # NOT USED: future hint for pagerduty's routing
      consecutive_priority: critical

      # For each chain there is a specific window of blocks and a percentage of missed blocks that will result in
      # a downtime jail infraction. Should an alert be sent if a certain percentage of this window is exceeded?
      percentage_enabled: no
      # What percentage should trigger the alert
      percentage_missed: 10
      # Not used yet, pagerduty routing hint
      percentage_priority: warning

      # Should an alert be sent if the validator is not in the active set ie, jailed,
      # tombstoned, unbonding?
      alert_if_inactive: yes
      # Should an alert be sent if no RPC servers are responding? (Note this alarm is instantaneous with no delay)
      alert_if_no_servers: yes

      # for this *specific* chain it's possible to override alert settings. If the api_key or webhook addresses are empty,
      # the global settings will be used. Note, enabled must be set both globally and for each chain.

      # Chain specific setting for pagerduty
      pagerduty:
        enabled: yes
        api_key: "" # uses default if blank

      # Discord settings
      discord:
        enabled: yes
        webhook: "" # uses default if blank

      # Telegram settings
      telegram:
        enabled: yes
        api_key: "" # uses default if blank
        channel: "" # uses default if blank

    # This section covers our RPC providers. No LCD (aka REST) endpoints are used, only TM's RPC endpoints
    # Multiple hosts are encouraged, and will be tried sequentially until a working endpoint is discovered.
    nodes:
      # URL for the endpoint. Must include protocol://hostname:port
      - url: tcp://localhost:26657
        # Should we send an alert if this host isn't responding?
        alert_if_down: yes
      # repeat hosts for monitoring redundancy
      - url: https://some-other-node:443
        alert_if_down: no
```


### 🚧Servis olusturuyoruz
```
sudo tee /etc/systemd/system/tenderdutyd.service << EOF
[Unit]
Description=Tenderduty
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=5
TimeoutSec=180

User=$USER
WorkingDirectory=$HOME/tenderduty
ExecStart=$(which tenderduty)


LimitNOFILE=infinity

NoNewPrivileges=true
ProtectSystem=strict
RestrictSUIDSGID=true
LockPersonality=true
PrivateUsers=true
PrivateDevices=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable tenderdutyd
sudo systemctl start tenderdutyd
Now you can see the logs
sudo journalctl -fu tenderdutyd
```
### 🚧Bağlanalım 
- Altta `<YOUR_SERVER_IP>` yazan kısmı silip sunucu ipsini yazın ve valaaa :D
```
http://<YOUR_SERVER_IP>:8888
```
![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/4f123c17-24f4-4137-a047-b45041814b49)

### 🚧Telegram Bot Ayarlama

- > @BotFather telegramda botfaher yazıp mavi tıklı arkadasa tıklayıp /help yazalım `isme lütfen dikkat edin`

![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/21367769-d5e6-49cd-b711-6c420849dbfd)

- > /newboat tıklayın yada yazın. botun ismini adını belirleyin gibi 2 soru sorduktan ona size api adresini vericek. bu botumuzun api adresi
- > Daha sonra uyarıları almak için kendinize tg üzerinde bir grub kurun olusturduğunuz botu kişi ekle diyerek ekleyin. @MissRose_bot ekleyelim yonetici yetkisi verelim 2 sinede daha sonra /id yazalım bize grub idmizi rose hanım vericek
- > Alttan nano ile dosyayı duzenle deyip tg kısmında apimizi yazalım. chat idmizi yazalım. ctrl x y ile kaydedelim.

```
nano $HOME/tenderduty/config.yml
```
![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/69e1672c-cfa5-4206-b6d5-6f929c833ccc)

- > Daha sonra https://api.telegram.org/botBURASI/getUpdates    `BURASI` yazan kısma bot olustuduğumuz api adresini yazalım. ve bu linki browsere yapıstıralım bize şöle bir cıktı vericek 

![image](https://github.com/molla202/Cosmos-Tenderduty/assets/91562185/6134bda3-c7c4-4df7-a7db-826e86624c1e)

- > eğer sadece ok result çıkarsa botu grubdan çıkarıp tekrar ekleyin. uzunca yazılar çıkması lazım



#### 🚧Restart Tenderduty
```
sudo systemctl restart tenderdutyd && sudo journalctl -fu tenderdutyd
```
