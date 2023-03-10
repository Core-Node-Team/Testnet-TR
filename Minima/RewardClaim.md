<div align="center">

# Minima Ödül Talebi & Cüzdan Yedeklemesi Nasıl yapılır?
  
![MİNİMAKAPAK](https://user-images.githubusercontent.com/76253089/223840438-762b606d-45f5-4cfe-9d12-4f12e0f6e461.jpg)

  <h3>
  
Herhangi bir sorunla karşılaşırsanız Telegram Sohbet Grubumuza bekleriz [Core Node Chat](https://t.me/corenodechat) <br>
Diğer Rehberlerimize göz atmak için burayı ziyaret edebilirsiniz [Github Sayfamız](https://github.com/Core-Node-Team)
  
</h3>
  
</div>

Yapmamız gerekenlerı kısaca özetliyorum. Öncelikle Minimum 2cpu 2 ram sunucu temin ediyoruz ve içine Minima Nodunu kuruyoruz. MiniDappe bağlanıyoruz. Orada Terminali bulup önce Write yetkisini veriyoruz sonra da terminale giriş yapıyoruz. "vault" komutu ile Cüzdan kelimelerimizi, "backup password:" komutu ile de node yedeğimizi alıyoruz. Sonrasında Ip Reward MDSini indirip Minidappe kuruyoruz ve cüzdanımıza ödülleri claim ediyoruz o kadar..

<details>

<summary> 
<h2> 1) Minima Kurulumu 
</summary> </h2>

## Güncelleme ve Gerekli Dosyaları Kuralım.
```
sudo su
```
```
sudo apt update 
```
```
sudo apt upgrade
```
## Minimayı Kuralım.

```
sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
```
```
sudo chmod +x ./get-docker.sh && ./get-docker.sh
```

## Minimayı Kuralım.
Mini Dappe Erişmek için Şifreniz 123 olacak bunu unutmayın!

```
docker run -d -e minima_mdspassword=123 -e minima_server=true -v ~/minimadocker9001:/home/minima/data -p 9001-9004:9001-9004 --restart unless-stopped --name minima9001 minimaglobal/minima:latest
```
```
sudo systemctl enable docker.service
```
```
sudo systemctl enable containerd.service
```
## Kurulum Bitti Şimdi Nodeu Kontrol edelim.

``docker ps`` yazın ve CONTAINER ID altındaki komutu aşağıda BURAYA yazan yer ile değiştirin. Örnek "docker logs k3msdlxc31 --follow"
```
docker ps
```
```
docker logs BURAYA --follow
```
![minimadockerps](https://user-images.githubusercontent.com/76253089/223828847-c0f0d836-92f3-489e-ae38-a616de45d600.png)

## Eğer Bu şekildeyse sorun yoktur diğer adıma geçelim.
![nodecıktısıbusekil](https://user-images.githubusercontent.com/76253089/223829381-fef586de-300d-40bb-93b5-11f1c063bbc1.png)

</details>

<details>

<summary> 
<h2> 2) MiniDappe Erişim ve Cüzdan Kelimelerini Yedekleme
</summary> </h2>

## Chromea girip yeni sekme açalım ve aşağıdaki komutla Minidappe erişelim.
Server İpinizi alttaki yazı ile değişin. Çıkan Ekrandaki yere 123 yazın.
```
https://SERVERIPNİZ:9003/
```
![image](https://user-images.githubusercontent.com/76253089/223830842-f2acbe28-df55-4716-b808-a553bef1103e.png)

## Şifreyi girdikten sonra Main Menu Tusuna basın. Karşınıza Dappler gelecektir. Bizim işimiz öncelikle terminalle. Write Tuşuna Basarak Gerekli izini verelim ve tekrar main menuye dönelim.

![image](https://user-images.githubusercontent.com/76253089/223831980-10fe3bc7-5d4b-41d6-848e-573e796139f8.png)

## Sonrasında Terminalin Üstüne 1 Kere basıp içine giricez. Bizi Alttaki gibi Siyah Ekran Karşılayacak. Buraya Alttaki Komutu yazın ve Çıkan çıktıyı tamamiyle kopyalayıp yedekleyin.

```
vault
```

![image](https://user-images.githubusercontent.com/76253089/223834160-e8636b42-79da-41a5-a88b-4f0cdd97333a.png)


## Cüzdan Yedekleme İşlemi Bu Kadardı. Şimdi Backup dosyamızı alalım. Bir sonraki aşamaya geçin.

</details>

<details>

<summary> 
<h2> 3) Backup alma ve Winscp Bağlantısı
</summary> </h2>

## Bu işlemi tekrardan terminal üzerinden yapıcaz. Terminale Write yetkisini verelim ve içine girelim. Sonrasında terminale "backup password:" yazalım (tırnak olmadan)

![image](https://user-images.githubusercontent.com/76253089/224300080-ecc7beb7-1304-4a31-b3c6-e2ff09e4b140.png)

## Şimdi oluşturulan dosyayı WİNSCP Programı ile sunucumuza bağlanıp kendi bilgisayarımıza alalım. Winscpyi indirip sunucunuza bağlanın

 <h2>
    [WinScp İndirme Linki](https://winscp.net/eng/download.php)
  </h2>

Eğer sunucuya bağlanırken private key dosyası kullanmıyorsanız 2. adımı es geçin.

![image](https://user-images.githubusercontent.com/76253089/223129569-e26ca533-89e1-4a13-b210-2a58b58b8480.png)

## Backup Dosyamız root/minimadocker9001 dizininde. Orayı bulup dosyamızı yedekleyelim

![image](https://user-images.githubusercontent.com/76253089/224300991-f521d451-cc1b-431d-bb86-192e141a808c.png)

## Sonraki Adıma Geçin
</details>

<details>

<summary> 
<h2> 4) Ödülleri Cüzdanımıza Talep Etme
</summary> </h2>

## Altta verdiğim Linke girip Incentive Program Rewards 2.15.1 MiniDappini indirmemiz gerekiyor. İşaretledigim yere basarak indirin.
  <h2> Tıkla İndir https://minidapps.minima.global/ </h2>
  
![image](https://user-images.githubusercontent.com/76253089/223836309-d043fdae-52fa-4ce4-9a1d-da1fb5e93a52.png)
  
## Sonrasında MiniDapp alanına tekrar dönelim. İşaretlediğim yerden az önce indirdiğimiz dosyayı sitenin içine atıp kurmamız gerekiyor. Sonrasında Install tusuna basıp uygulamayı kurun.
  
  ![image](https://user-images.githubusercontent.com/76253089/223836701-ac0d8fa9-c6d6-45b2-91a2-56db49236564.png)

## Bu Dappe de Write iznini verelim. Sonrasında tıklayıp içine erişelim.
  
  ![image](https://user-images.githubusercontent.com/76253089/223837322-6f1b54db-2c60-4f43-9878-75fae7791ced.png)
  
## Buraya Bilgilerimizi girip Giriş yapmamız lazım.
  
  ![image](https://user-images.githubusercontent.com/76253089/223837676-7274cfbe-f6d8-4045-b81b-bc19896090f4.png)

## Request Withdrawal tusuna bastıktan sonra ödüllerimizi claim etmiş olucaz. Hemen yansımayacak Dağıtımın 21 Mart civarı başlayacağını söylüyorlardı emin değilim. Biz duyuru olarak paylaşacağız.
  
  ![request](https://user-images.githubusercontent.com/76253089/223838011-251299aa-67bc-4524-a477-439460abd0bf.png)
  
## İşlemler Bu kadar...
  
  </details>
  
Seedinizi kaybederseniz ödülleriniz de gider arkadaşlar o yüzden güvenli bi şekilde sakladığınıza emin olun. Eğer yapamadığınız bi yer varsa kanalımıza gelip bize sorabilirsiniz. İşinize yaradıysa Sağ üstten Favori+Fork tuşuna basın.


![logo2WB](https://user-images.githubusercontent.com/76253089/224302609-79eb6f6c-c711-4251-9305-d5bb13d7452d.jpg)
