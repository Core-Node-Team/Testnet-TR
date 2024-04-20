## RiscZero Ceremony

BU PAYLAŞIM coinsspor TARAFINDAN HAZIRLANMIŞTIR...

### 🖥Donanım Gereksinimleri :
✅- Memory: 8GB++ RAM (discordda 4ram de olabilir dedi mod)

✅ Bandwidth: 25 Mbps  Download/Upload

🌍Website: https://www.risczero.com/

🌍Detay: https://www.risczero.com/blog/ceremony-contribution-public-instructions

🌍AnaRehber: https://p0tion.super.site/ce8f7047468b41239dc512919644535c

### ✅GitHub Hesabı Gereksinimleri:
En az 1 adet kamu erişimli depo sahibi olmalısınız.
En az 5 GitHub kullanıcısını takip ediyor olmalısınız.
En az 1 takipçiye sahip olmalısınız.
Beni takip edin  https://github.com/coinsspor

### ✅Kurulum:
Bağımlılıkları Kurma ve İkili Dosyaları Yükleme:
```
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | sh -
source ~/.profile
mkdir p0tion-tmp
cd p0tion-tmp
nvm install 16.20
nvm use 16.20
npm install @p0tion/phase2cli
```
### ✅GitHub Hesabını Doğrulama
Not: kodu girince sayfada size bir kod vericek. bu linke gidip o kodu yapıstırıcaksınız. https://github.com/login/device
```
npx phase2cli auth
```
### ✅Katkıda Bulunma:
Bu adım etkileşimli bir kabuk olduğundan ve arka planda çalıştırılamayacağından, işlem sırasında screen kullanılacaktır.
```
screen -S risczero
```
```
npx phase2cli contribute
```
### ✅Yönergeleri takip edin ve "xxx katılımcı beklemelisiniz (~xx:xx:xx:00 (gg/ss/dd/ss))" mesajını görene kadar devam edin.
Ekranı kapatmak için CTRL tuşunu basılı tutarak A tuşuna ve ardından D tuşuna basın.
İlerlemenizi kontrol etmek için
```
 screen -r risczero 
```
komutunu kullanın.

### işlemler başarılı şekilde bitince altaki kodu çalıştırın
```
npx phase2cli clean
```

