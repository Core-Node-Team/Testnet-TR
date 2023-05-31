 <h1 align="center"> Opside Network | Validator Node Otomatik Kontrol Etme Aracı </h1>

![image](https://github.com/ahmkah/Testnet-TR/assets/99053148/19b997dc-983d-496a-b822-a82a5021f61b)


# Aşağıdaki Komutları çalıştırın ve Açıklamaları Takip Edin 

İlk önce wget yüklüyoruz
```
sudo apt install wget
```
Aşağıdaki klasörün içinde çalıştırmamız gerekli aşağıdaki kodu girin
```
cd
cd testnet-auto-install-v2/opside-chain
```

Trasnlate adında yeni bir klasör oluşturuyoruz 
```
mkdir translate
```
Aşağıdaki komutları sıra ile giriyoruz
```
wget -c https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Opside/testnet-auto-install-v2/translate/control-panel_en_US.transhell -O ./translate/control-panel_en_US.transhell
```
```
wget -c https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Opside/testnet-auto-install-v2/translate/control-panel_zh_CN.transhell -O ./translate/control-panel_zh_CN.transhell
```
```
wget -c https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Opside/testnet-auto-install-v2/translate/control-panel_tr_TR.transhell -O ./translate/control-panel_tr_TR.transhell
```
```
wget -c https://raw.githubusercontent.com/Core-Node-Team/Testnet-TR/main/Opside/testnet-auto-install-v2/control-panel.sh -O ./control-panel.sh 
```
```
chmod +x ./control-panel.sh
```
İşlem Bu kadar sonra ilgili klasörün içindeyken (testnet-auto-install-v2/opside-chain) aşağıdaki komutu çalıştırıp keyfini çıkarın
```
bash ./control-panel.sh
```
