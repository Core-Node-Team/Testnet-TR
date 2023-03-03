# Hosting.com.tr sitesinde DNS ayarı nasıl yapılır?

## Alttaki linke tıklayın ve sağdaki yönet tusuna basın.

[Buraya Tıkla](https://www.hosting.com.tr/musteri-paneli/domainlerim)

![image](https://user-images.githubusercontent.com/76253089/213944894-318c0025-5b4e-4824-9962-83700cacf02e.png)

## Soldaki NS OLUŞTURMA alanına gelin ve fotoğraftaki gibi doldurun.

![image](https://user-images.githubusercontent.com/76253089/214102422-917902d4-5851-48ab-a03e-44a3cd78604b.png)


## Solda Domain Parking Menüsünün altında DNS Zone yönetimine tıklayın ve Domain Parkingi etkinleştirin

![image](https://user-images.githubusercontent.com/76253089/213945027-c993fd84-8ebf-4c6d-8231-a7b2fac13d6e.png)

## İşaretlediğim yerleri fotoğraftaki gibi doldurun ve kaydedin.

![image](https://user-images.githubusercontent.com/76253089/214024667-88d51c70-1257-4d0b-9d50-991e48bdbad5.png)

Arkadaşlar name service örneği `` ns1.sarcodomain.com.tr.`` şeklinde olacak. Sonuna nokta koymayı unutmayın..

## Ekledikten sonra alttaki siteden kontrol edelim. Eğer sunucu ipniz gözüküyorsa başarılıdır.
[Kontrol etme sitesi](https://www.nslookup.io/domains/ns1.enzifiri.me/dns-records/)

![image](https://user-images.githubusercontent.com/76253089/214025396-252e01d8-33bc-42be-9020-742c6eeee4be.png)


## Şimdi Terminale bağlanıp sunucunuzda bi kaç değişiklik yapmamız lazım.
`` nano .env`` komutu ile aşağıdaki ekrana girin ve domain kısmını ns1li şekilde düzenleyin alttaki örneğe bakabilirsiniz. <br>
Burda sonuna nokta koymayın. <br>
Değişiklikleri kaydetmek için Ctrl + x + y + enter 
![image](https://user-images.githubusercontent.com/76253089/214025844-3ff1690e-7694-4806-b42f-8e573c1ab0c3.png)

## nano .env dosyasını düzenledikten sonra alttaki komutları girin

``cd quickstart-archaeologist`` <br>
``docker compose exec -it archaeologist sh`` <br>
``cli update -g`` <br>
``exit`` <br>
``COMPOSE_PROFILES=service docker compose stop``  <br>
``COMPOSE_PROFILES=service docker compose pull`` <br>
``COMPOSE_PROFILES=service docker compose up -d`` <br>

## Şimdi loglarımızı kontrol edelim.

`` docker container ls`` yazın ve en alttaki ngix-proxy containerini kontrol edelim <br>
``docker logs containerid --follow`` container id kısmına ngix-proxy idsini girin
![image](https://user-images.githubusercontent.com/76253089/214026601-256822aa-1180-498a-9ad2-907651a3cba2.png)

Üstteki kırmızı yazılara takılmayın . Alttaki gibi çıktılar görüyosanız başarılıdır.
![image](https://user-images.githubusercontent.com/76253089/214026905-4dd56b7e-42a9-4a1b-a57a-8f80a5824ce9.png)

Şimdi diğer containeri kontrol edelim.
`` docker container ls`` yazın ve en alttaki sarcophagus ile başlayan containerini kontrol edelim <br>
``docker logs containerid --follow`` container id kısmına sarcopuacus idsini girin

![image](https://user-images.githubusercontent.com/76253089/214027389-4ca6e5b0-1e72-4156-8f7c-b69089bb95d6.png)

Loglarınız bu şekildeyse başarılıdır. Bu işlemi yaptıktan sonra biraz bekleyin loglar yavaş akıyor.
![image](https://user-images.githubusercontent.com/76253089/214027566-8f54e0d7-9433-4ea9-aafc-8bf722f92224.png)

## Bütün işlemleri yaptıktan sonra kontrol aşamasına geçelim alttaki siteye girin ve cüzdan adresinizi kontrol edin

[Siteye gitmek için tıkla](https://dev-sarcophagus.netlify.app/archaeologists)

Cüzdanınız gözüküyorsa tamamdır. Başardınız....
![image](https://user-images.githubusercontent.com/76253089/214027859-8a91f2d6-2ef2-4943-8d1a-75de6cad8ddd.png)
