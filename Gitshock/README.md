<h1 align="center"> Gitshock Cartenz Chain </h1>
<div align="center">





![image](https://user-images.githubusercontent.com/108215275/229382287-58aae37d-cab5-4b8e-85c9-c6fc768e8e70.png)

## Gitshock resmi hesapları: [Twitter](https://twitter.com/gitshock)|[Discord](https://discord.gg/Gu22k9cu)|[Github](https://github.com/gitshock-labs)|[Docs](https://docs.gitshock.com/)

</div>

# Gitshock Chain EVM Testnet
> ### Cartenz Chain, Gitshock EVM testneti için oluşturulmuş bir Ethereum Beaconchain forkudur.

> ### Bir node oluşturup blok zincire bağlanabilmek için Client yazılımları kullanmak gerekir. Cartenz Chain, EVM uyumlu bir blok zincir olduğundan Ethereum clientleri  Cartenz Chaine bağlanmak için kullanılır. 
> ### Bu rehberde Execution layer için ***Geth***, Consensus layer için ***Lighthouse*** clientlerini kullanarak Cartenz Chaine bağlanacağız. (başka clientler ile de ağa katılınabilir.)
> ### Sistem gereksinimleri (tavsiye edilen):
>  - 4CPU 4GB RAM 250-500 GB SSD

# Sunucu Güncellemesi
```
sudo apt-get update && sudo apt-get upgrade -y
```
# Güvenlik ayarları
> ### Bu kısım isteğe bağlı.

> ### Nodu korumak ve güvenceye almak için bazı temel güvenlik ayarları yapılması gerekir. Burada basit olan ssh portunu değiştirme ve firewal yapılandırmasını anlatacağım. Gitshockun tavsiye ettiği daha kapsamlı güvenlik ayarlarını yapmak isterseniz: [Link](https://docs.gitshock.com/gitshock-testnet-overview/gitshock-chain-evm-testnet/secure-the-server#secure-the-server)

## SSH portunu değiştirin
> `1024–49151` arasında bir port seçin `8545,30303,5052,5053,9000,8550,8551` portları haricinde. Seçtiğiniz portun boşta olduğunu öğrenmek için `sudo netstat -tnlp | grep :<PortNumarası>` komutunu kullanabilirsiniz. Komut bir çıktı vermiyorsa bu portu kullanan bir şey yok demektir.

> SSH yapılandırmasını değiştirin
> - `sudo nano /etc/ssh/sshd_config` komutu ile dosya içine girin.
> - Yön tuşları ile `#Port 22` yazan kısıma gelin `#` işarteini silip `22` yerine değiştirmek istediğiniz port numarasını girin.
> - `CTRL+X` ardından `y` ardından `Enter` ile kaydedip çıkın.

> SSH servisi yeniden başlatın
> - `sudo systemctl restart ssh`
> - Oturumu kapatın ardından yeniden bağlanın. Bağlanırken ssh için değiştirdiğiniz portu kullanmayı unutmayın.

## Firewall yapılandırması
> Default olarak tüm gelen trafiği reddedip giden trafiğe izin verin
> - `sudo ufw default deny incoming`
> - `sudo ufw default allow outgoing`

> SSH portuna izin verin
> - `sudo ufw allow <SSHPort>/tcp`
> - `SSHPort` yazan yeri kendi belirlediğiniz port numarası ile değiştirmeyi unutmayın.

> Kullanılacak portları açın
> - `sudo ufw allow 42069`
> - `sudo ufw allow 42069/tcp`
> - `sudo ufw allow 42069/udp`
> - `sudo ufw allow 8545/tcp`
> - `sudo ufw allow 8550/tcp`
> - `sudo ufw allow 8551/tcp`
> - `sudo ufw allow 5051/tcp` 
> - `sudo ufw allow 5052/tcp` 
> - `sudo ufw allow 5053/tcp` 
> - `sudo ufw allow 9000/tcp`
> - `sudo ufw allow 9001/tcp`
> - `sudo ufw allow 30303/tcp`
> - `sudo ufw allow 30303/udp`
> - `sudo ufw allow 3000`

> Firewall etkinleştirin
> - `sudo ufw enable`
> - `ufw status` komutu ile ayarları görüntüleyebilirsiniz.


# Kütüphaneler
```
sudo apt install curl tar wget tmux htop net-tools clang  libssl-dev jq micro build-essential git screen gcc g++ cmake pkg-config llvm-dev libclang-dev clang protobuf-compiler make ncdu -y 
```

# Go
```
cd
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
```
# Geth
```
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update -y
sudo apt install ethereum -y
sudo apt install jq
go install github.com/protolambda/eth2-testnet-genesis@latest
go install github.com/protolambda/eth2-val-tools@latest
```

# Rust
```
cd 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
``` 
# Lighthouse
```
git clone https://github.com/sigp/lighthouse.git
cd lighthouse
git checkout stable
make
```
## İsim ve cüzdan adresinizi bash_profile kaydedin
> ### Cüzdan adresi için metamasktan yeni bir cüzdan oluşturabilirsiniz
```
echo "export ISIM="<isminiz>"" >> $HOME/.bash_profile
echo "export CUZDAN="<cüzdanadresi>"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
# Cartenz Chain kaynak dosyaları
```
cd
git clone https://github.com/gitshock-labs/testnet-list
```
# Loglar ve data için klasörler
> ### Komutları tek tek girin.
```
cd testnet-list
mkdir beacon-1
mkdir beacon-2 
mkdir validator
mkdir logs
cd logs
touch geth.log
touch beacon_1.log
touch beacon_2.log
touch validator.log
cd ..
```
# Staking-cli
```
git clone https://github.com/gitshock-labs/staking-cli.git
cd staking-cli
git checkout main
sudo apt install python3-pip -y
pip3 install -r requirements.txt
sudo python3 setup.py install
./deposit.sh install
```
## Validatör keyleri oluşturun
```
./deposit.sh new-mnemonic
```
> ### Komutu girdikten sonra
> - İlk soruya `3` yazın
> - İkinci soruya `4`
> - Sonraki soru kaç validatör çalıştıracaksınız, `1` yazın
> - Hangi zincirde çalıştıracağınızı soruyor, `cartenz` yazıp enter.
> - Son olarak şifre oluşturmanızı isteyecek
![image](https://user-images.githubusercontent.com/108215275/229634233-dcdd0f2c-79a1-4b98-bc04-598c40de188e.png)
> ### Şifrenizi girdikten sonra mnemonicler görünecek. Bunları kaydedip bir yere saklayın. Ardından bir tuşa basın mnemonicleri tekrar girmenizi isteyecek. Ve validatör keyleri oluşturulacak. 
> - ![image](https://user-images.githubusercontent.com/108215275/229634571-69ba507a-b2eb-41b5-be20-fb1b648f4b1f.png)
> 

# JWT Secret oluşturun
```
cd ..
openssl rand -hex 32 | tr -d "\n" > "jwt.hex"
```
# İnitalize
```
geth --datadir /root/testnet-list/cartenz-data init /root/testnet-list/execution/genesis.json
```

# Execution Layerde hesap oluşturun
> ### Şifre oluşturmanızı isteyecek
```
geth account new --datadir "cartenz-data"
```

# Execution Layer çalıştırın
```
screen -S geth
```
```
nohup geth \
--http --http.api="admin,eth,net,web3,txpool" \
--http.port 8545 \
--authrpc.port 8551 \
--discovery.port 30303 \
--port 30303 \
--http.addr 0.0.0.0 \
--authrpc.addr 0.0.0.0 \
--authrpc.jwtsecret /root/testnet-list/jwt.hex \
--datadir /root/testnet-list/cartenz-data \
--http.corsdomain=* \
--http.vhosts=* \
--networkid=1881 \
--syncmode=full \
--identity "$ISIM" \
--cache 1024 \
--bootnodes "enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303,enode://45b4fff6ab970e1e490deea8a5f960d806522fafdb33c8eaa38bc0ae970efc2256fc5746f0ecfec770af24c44864a3e6772a64f2e9f031f96fd4af7fd0483110@147.75.71.217:30304" \
> /root/testnet-list/logs/geth.log
```
> ### Screenden CTRL+A+D ile çıkış yapın.

# Konsola giriş yapın
```
geth attach http://localhost:8545
``` 
> ### Peer adresini öğrenmek için
>  - `admin.nodeInfo.enode`
>  ### Bağlandığınız peerleri görmek için
>  - `admin.peers`
>  ### Bağlandığınız peerlar arasında [bu sitedeki](https://nodemoon.cartenz.works/) isimlerde bir veya birkaçı varsa sonraki adıma geçebilirsiniz.
>   - Örnek
>   ![image](https://user-images.githubusercontent.com/108215275/229636258-5697707d-d6c4-44d3-976d-868c8a330e9d.png) ![image](https://user-images.githubusercontent.com/108215275/229636278-81a3754c-a9d1-492e-80f8-55bf3099aa99.png)
> ### Peer eklemeniz gerekirse;
> - `admin.addPeer("enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303")`
> - `admin.addPeer("enode://788554bcd8db8f31c7dac64794116f075602a0e75fbc6563104d3aec921c6f1f0ff58d134f1b68c1d3ff51d0fa82354a75f5367e677905fb0f6a60212c78b28f@94.250.202.24:30303")`
> - `admin.addPeer("enode://e269ff4567a0d259b94a72f8339704ca65d424140d445fb32e1bf40e66b2c35c392988227355ce125fc1049a616a644e86b61e9ea4bffb55679dacb9f1df0576@24.199.107.199:42468")`
>  - `admin.addPeer("enode://787282effee17f9a9da49b3376f475b1521846ee924c962595e672ee9b90290e39b9f2fb67a5f34fb1f4964353cd6ef2a989c110d53b8fd169d8481c44f93119@44.202.92.152:43070")`
>  - `admin.addPeer("enode://96122271991bd4353094d315f7952aae5ff406941e21187dcee3b8867dcee661a48048133837e0453910627c8c9905a435ed1ae99af4658f81e0bd5d230641f5@185.180.220.144:44382")`
>  - `admin.addPeer("enode://610f95b111e16d6ff83fe9c7cd0aaa4a38aacd410acef9615399ef0aee74550531af19663bf0f79969f62e06e84942a23aaf90052a05292b53e0eb1a2323ffc9@46.101.252.143:30303")`
> 
> `exit` ile konsoldan çıkış yapın.

# Consensus Layer başlatın
```
screen -S beacon1
```
```
 nohup lighthouse \
--testnet-dir="/root/testnet-list/consensus" \
--datadir /root/testnet-list/beacon-1 \
--eth1 \
--http \
--gui \
--http-address 127.0.0.1 \
--http-allow-origin="*" \
--http-allow-sync-stalled \
--execution-endpoints http://127.0.0.1:8551 \
--http-port 5052 \
--enr-udp-port=9000 \
--enr-tcp-port=9000 \
--discovery-port=9000 \
--jwt-secrets="/root/testnet-list/jwt.hex" \
--graffiti "$ISIM" \
--suggested-fee-recipient=$CUZDAN \
> /root/testnet-list/logs/beacon_1.log
```
> ### Screenden CTRL+A+D ile çıkış yapın.
# ENR Key
> ### Çıktısını kaydedin.
```
curl http://localhost:5052/eth/v1/node/identity | jq
```
![image](https://user-images.githubusercontent.com/108215275/229759465-7fa81970-903e-4896-a537-ac0a9509b6cf.png)

# İkinci Consensus Layer başlatın
```
screen -S beacon2
```
> ### `<SizinENRKey>` yazan yazan yere bir önceki komutta elde ettiğiniz ENR keyi girin
```
nohup lighthouse beacon \
--testnet-dir="/root/testnet-list/consensus" \
--datadir /root/testnet-list/beacon-2 \
--http \
--eth1 \
--gui \
--http-address 127.0.0.1 \
--http-allow-origin="*" \
--http-allow-sync-stalled \
--execution-endpoints http://127.0.0.1:8551 \
--http-port 5053 \
--enr-udp-port=9001 \
--enr-tcp-port=9001 \
--discovery-port=9001 \
--port=9001 \
--jwt-secrets="/root/testnet-list/jwt.hex" \
--graffiti "$ISIM" \
--suggested-fee-recipient="$CUZDAN" \
--boot-nodes="<SizinENRKey>,enr:-MS4QHXShZPtKwtexK2p9yCxMxDwQ-EvdH_VemoxyVyweuaBLOC_8cmOzyx7Gy-q6-X8KGT1d_rhAn_ekXnhpCkA_REHh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQJB10N42nK6rr7Q_NIJNkJFi2uo6itMTOQlPZDcCy09T4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIyiDdWRwgiMo,enr:-MS4QEw_RpORuoXgJ0279QuVLLFAiXevNdYtU7vR8S1CY7X9CS6tceMbaxdIIJYRmHN43ClqHtE2b0H0maSb18cm9D0Hh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQOkQIyCVHLbLjIFMjqNSJEUsbYMe4Tsv9blUWvN6Rsft4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIymDdWRwgiMp" \
> /root/testnet-list/logs/beacon_2.log
```
> ### Screenden CTRL+A+D ile çıkış yapın.

# Buraya kadar hata almadan yaptıysanız

## Geth logları önce böyle görünecek
> ### `tail -f /root/testnet-list/logs/geth.log`
![image](https://user-images.githubusercontent.com/108215275/229638094-9fff98c5-1443-4420-9300-48a4a0c06661.png)

## Ardından böyle görünecek
![image](https://user-images.githubusercontent.com/108215275/229638381-478ef819-66f2-4c18-9cc2-4bb018c4a957.png)


## Beacon_1 logları
> ### `tail -f /root/testnet-list/logs/beacon_1.log`

![image](https://user-images.githubusercontent.com/108215275/229638522-b6c7fa8e-54dd-4e4b-8856-729e4912b09d.png)

## Beacon_2 logları
> ### `tail -f /root/testnet-list/logs/beacon_2.log`
![image](https://user-images.githubusercontent.com/108215275/229638665-5cc2c76b-8337-4f18-9ad3-74d7161afa26.png)

### Son olarak ip adresinizi discordda `#cartenz-testnet-server`kanalına gönderin. Nodeniz [nodemoonda](https://nodemoon.cartenz.works/) görünmeye başlayacak.


