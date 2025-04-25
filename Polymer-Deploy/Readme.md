
<h1 align="center"> Polymer Labs </h1>

![8e33d546-0b40-4b06-b477-741b80d253aa-1678476461078](https://github.com/molla202/Polymer-test1/assets/91562185/9616c55a-0271-4a25-9677-88aa86681ae1)

 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>


## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	2|
| RAM	| 2+ GB |
| Storage	| 40 GB SSD |

### 🚧 Başlayalım

```
git clone https://github.com/molla202/Polymer.git
```
```
cd Polymer
```
```
sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget -y
```
```
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
```
```
sudo apt-get install -y nodejs
```
```
curl -L https://foundry.paradigm.xyz | bash
```
```
source /root/.bashrc
```
```
foundryup
```
```
wget -qO - 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [arch=all,$(dpkg --print-architecture) signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
sudo apt update
```
```
sudo apt install just
```
```
just install
```
```
cp .env.example .env
```
```
nano .env
```

Not: alttakileri doldurmak için. apileri alalım. Blockscout aşadakilerle github bağlayarak alabilirsiniz.
```
PRIVATE_KEY_1='BURAYA PUAN ALMAK İÇİN GİTHUB BAĞLAMIŞTIK CÜZDAN BAĞLDIYSANIZ ONUN PRİVATE KEYİNİ YAZICAKSINIZ VE FAUCETLERİ ALICAKSINIZ. https://chainlist.org/?testnets=true&search=sepolia burdan ağları ekleyip kontrol edin faucet geldimi die'

OP_ALCHEMY_API_KEY='Alchemy op api'
BASE_ALCHEMY_API_KEY='Alchemy base api'
OP_BLOCKSCOUT_API_KEY=''
BASE_BLOCKSCOUT_API_KEY=''
```
Not: ctrl x y enter la kaydedelim

https://optimism-sepolia.blockscout.com/account/api-key

https://base-sepolia.blockscout.com/account/api-key

Not: Alchemy içinse https://dashboard.alchemy.com/apps    sepholia olanalrdna açıcaksınız birde faucet almanız gerekıyor. alchemy uye olduktan sonra aşağıdkai linklerden alabilirsiniz.

https://www.alchemy.com/faucets/optimism-sepolia

https://www.alchemy.com/faucets/base-sepolia

![image](https://github.com/molla202/Polymer-test1/assets/91562185/da37accc-a24f-440d-affe-b1260d0f60a8)



### Başlatalım
```
just do-it
```

![image](https://github.com/molla202/Polymer-test1/assets/91562185/4c893d6e-74e9-4620-9f3e-4d15af38d2a3)

Not: Discorddan Proof kanalına ss çıktınızı atın...








