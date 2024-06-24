<h1 align="center"> Nubit Light Node


![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/1c9b1831-2c0f-4ba6-bbb2-1fb75b624001)

</h1>

 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>
 * [Nubit Website](https://alpha.nubit.org/#/)<br>
 * [Discord](https://discord.gg/nubit)<br>
 * [Twitter](https://x.com/Nubit_org)<br>



## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2|
| RAM	| 4 GB |
| Storage	| 40++ GB SSD |

```
sudo apt-get update && sudo apt-get upgrade -y 
```
```
sudo apt-get install curl screen git-all build-essential glibc-source pkg-config libssl-dev clang git-lfs -y
```
```
curl -sL1 https://nubit.sh | bash
```

Not: hersey yuklenince başlar sonra ctrl c ile durdurun.

### Eğer daha önce görevleri yaptığınız keplr cüzdanı import edicekseniz kelimeleri alın alttaki kodla  import edin sorucak üzerine yazammı die oh yeahhh diyoruz :D

```
/root/nubit-node/bin/nkey add my_nubit_key --recover --p2p.network nubit-alphatestnet-1 --node.type light
```

### Servissiz olmaz

```
sudo tee /etc/systemd/system/nubitd.service > /dev/null <<EOF
[Unit]
Description=nubitd node
After=network-online.target
[Service]
User=$USER
ExecStart=/root/nubit-node/bin/nubit light start \
--p2p.network nubit-alphatestnet-1 \
--core.ip validator.nubit-alphatestnet-1.com \
--metrics.endpoint otel.nubit-alphatestnet-1.com:4318 \
--rpc.skip-auth
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
### başlatalım
```
sudo systemctl daemon-reload
sudo systemctl enable nubitd
sudo systemctl restart nubitd
```
### Log bakalım
```
sudo journalctl -u nubitd -fo cat
```

### eğer yeni giricekseniz.
Not: burda kelimeleriniz yazar. bunları keplr ekleyin sonra platforma bağlanın en başta linkler var zaten sonra görevleri yapın sizi yonlendiriyor.
```
nano /root/nubit-node/mnemonic.txt
```
### Pubkey öğrenme
NOT: cüzdan listelenecek burda pubkey kısmı var burdaki "key":"A/WJPVhPe8jYghfhgfhfgOEdfdfdbiD7ojC6thn4r1C"  2 tırnak arasında yazan kısım A/WJPVhPe8jYghfhgfhfgOEdfdfdbiD7ojC6thn4r1C kod sizin pubkey onu yazacaksınız 3k puanı kapacaksınız.
```
/root/nubit-node/bin/nkey list --p2p.network nubit-alphatestnet-1 --node.type light
```











