
<div align="center">
  <h1>Fleek-Network </h1>
</div>

![ghjklz](https://github.com/molla202/Fleek-Network/assets/91562185/83355aab-fdc4-46c8-bbe4-14f2cc19e76b)

* [CoreNode Telegram](https://t.me/corenodechat)<br>
* [CoreNode Twitter](https://twitter.com/corenodeHQ)<br>
* [Fleek Network](https://fleek.network/)<br>
* [Fleek Network Twitter](https://twitter.com/fleek_net)<br>
* [Fleek Network DOC](https://docs.fleek.network/docs)<br>


 ## 💻 Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| ✔️ CPU |	4 |
| ✔️ RAM	| 16 GB |
| ✔️ Storage	| ~GB SSD |

### RESMİ OTO KURULUM UBUNTU 22 HERSEY DAHİL
```
curl https://get.fleek.network | bash
```

### 🏠 Update edelim
```bash
sudo apt update; sudo apt upgrade 
```
### 🤖 Gerekli olanlar
```
sudo apt install screen curl tar wget jq build-essential make clang pkg-config libssl-dev cmake gcc
```
### 🤖 Rustup kuruyoruz
✏️ Not: 1 seçeceksiniz. daha önce kuruluysa kurmanıza gerek yok.
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```
source ~/.profile
source ~/.cargo/env
```
### 🤖 Protobuf ve sccache Kuruyoruz
```
cargo install sccache
```
```
sudo apt-get install protobuf-compiler
```

### 👷 `fleek-network/lightning.git` 'i klonluyoruz.
```
cd $HOME 
git clone https://github.com/fleek-network/lightning-node.git
cd lightning
```
```
cargo run -- keys generate
```
```
sudo ln -s "$HOME/lightning/target/debug/lightning-node" /usr/local/bin/lgtn
```
* `cargo +stable build` uzun sürer. hata verirse tekrar gir hata vermeyeseye kadar.
* daha sonra version kontrol edin: 📖`lgtn --version`
* version: `lightning-node 0.1.0`✅
### 🚀 Screen'de node'u çalıştıralım.

```
lgtn keys generate
```
NOT: çıkan bilgileri kaydedin
```
screen -S light
```
```
cd $HOME
```
```
cd lightning
```
```
lgtn run
```
![image](https://github.com/molla202/Fleek-Network/assets/91562185/d9ac7ef6-ba60-4952-a52d-c2a8cb92ae31)

* discord üzerinden işlem yapmamız gerekiyor şuan aktif değil detayları paylaşacağız.bilgileri giriyoruz 2 dane key ve ip adresi
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b3289542-9cc3-4868-a723-3536d19c5a4a)

* Loglar akıyorsa sorun yok.
* Loglar aktıktan sonra CTRL + A + D ile çıkın.
* Screen'e Tekrar Girmek için
```
screen -ar light
```
### tekrar keyleri görmek için 
```
cd lightning && cargo run -- keys show
```
YADA
```
lgtn keys show
```
### ♻️ Key dosyası yedekleme
* Dosyalarınız bu konumda yer alıyor. ``~/.lightning/keystore``  yedekleyiniz.alttaki kod port değişikliği için deneyeceğiz :D
```
nano ~/.lightning/config.toml
```

