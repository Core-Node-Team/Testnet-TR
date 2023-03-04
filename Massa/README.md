<h1 align="center"> Massa </h1>
<div align="center">


  ![image](https://user-images.githubusercontent.com/108215275/222922517-cceadc51-a833-409d-8b70-386c360fe83c.png)


 <h3>
 
  Massa Resmi Linkler: [Twitter](https://twitter.com/MassaLabs) | [Discord](https://discord.gg/massa) | [Website](https://massa.net/) | [MassaDocs](https://docs.massa.net/en/latest/index.html)
  
</h3>

 <h3>
 
   Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat)
  
 </h3>
  
</div>



# Güncelleme ve Kütüphaneleri kurma
```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev libclang-dev jq build-essential git screen make ncdu  -y 
```
# Rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source $HOME/.cargo/env
```
```
rustc --version
```
```
rustup toolchain install nightly-2022-12-24
```
```
rustup default nightly-2022-12-24
```
```
rustc --version
```


# Massa kaynak kodları
```
git clone --branch testnet https://github.com/massalabs/massa.git
```

# Nodu başlatın
```
screen -S massa
```
```
cd massa/massa-node/
```
* `<PASSWORD>` kısmına kendi belirlediğiniz bir şifre girin
```
RUST_BACKTRACE=full cargo run --release -- -p <PASSWORD> |& tee logs.txt
```
* Başlaması braz zaman alabilir. Screenden CTRL+A+D ile çıkış yapın
* Çalışmaya başladıktan sonra loglar böyle görünüyor.
* ![image](https://user-images.githubusercontent.com/108215275/222924547-ab227a22-28d0-44ad-90d9-8c978279cf32.png)


# Clienti başlatın
```
screen -S client
```
```
cd massa/massa-client/
```
* `<PASSWORD>` değiştirmeyi unutmayın
```
cargo run --release -- -p <PASSWORD>
```
![image](https://user-images.githubusercontent.com/108215275/222924765-adc346c6-16df-428c-a579-39820d308629.png)

# Cüzdan oluşturun
```
wallet_generate_secret_key
```
![image](https://user-images.githubusercontent.com/108215275/222924877-35186a65-be60-40b0-9172-0ba9ce647e14.png)
* Daha önceki cüzdanınızı kullanmak isterseniz
```
wallet_add_secret_keys <SecretKey>
```
* Cüzdan bilgileri için
```
wallet_info
```
## Massa [discord](https://discord.gg/massa)a gidip `#testnet-faucet` kanalına sadece cüzdan adresinizi göndererek test tokenlarını alın

# Cüzdanı noda tanımlayın
```
node_start_staking <your_address>
```
![image](https://user-images.githubusercontent.com/108215275/222925056-4db91d2d-60f0-4074-89ca-5971d160800b.png)
# Rulo satın alın
* `<address>`kısmına kendi adresiniz yazmayı unutmayın
```
buy_rolls <address> 4 0
```
## Satın aldığınız ruloların aktif hale gelmesi 2 saat kadar sürecektir.

# Nodu discord hesabına tanımlama
### Şimdi discordda testnet-rewards-registration kanalına gidip ilk mesajdaki emojiye tıklayın ardından bot size özel mesaj atacak. Mesaj gelmezse discord gizlilik ayarlarında direkt mesaj alma kısmı kapalıdır.
### Botun attığı mesajda görseldeki komut var. Bu komuta kendi cüzdan adresinizi yazıp girin.
![image](https://user-images.githubusercontent.com/108215275/222925383-08caf3c3-0d50-46d2-a30f-3ff9b0ea3f71.png)

### Çıktısında böyle uzun bir komut var. Bunun tamamını kopyalayıp massa bota gönderin.
![image](https://user-images.githubusercontent.com/108215275/222925556-03e30f72-c791-4f75-adfd-01a5bfa74d8b.png)

### Son olarak sunucunuzun ip adresini de massa bota gönderin. Böylece discord tanımlama işlemi de tamamlanmış olacak






















