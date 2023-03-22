<h1 align="center"> Taiko </h1>

![photo_2023-03-22_20-42-23](https://user-images.githubusercontent.com/76253089/227009924-94c54223-e7fb-4844-a9f2-00f95c400942.jpg)


## Taiko V2 Node Kurulumu, Arkadaşlar ödül olarak 50k$ ayırmışlar fakat kurmadan önce ekibin açıklamasını okumanızı öneririm. Sunucunun maliyeti fazla olacak, ekipte bunun farkında hedef olarak maliyetlerinizin %10 üstü vermeyi amaçlıyorlar çok fazla detay vermemişler. [Makaleyi okumak isterseniz](https://mirror.xyz/labs.taiko.eth/A6G6TNN-CXDAhl42k_bNHg_20fyGcT0xH-LBBSOPNzU) <br>

![image](https://user-images.githubusercontent.com/76253089/227015343-e18eb4f1-29f9-458f-b817-b0d70de9711d.png)


## Min Gereksinimler:

8 CPU  <br>
32 GB RAM <br>
100 GB SSD <br>

<details>

<summary> 
<h2> 1) Taiko Kurulum Aşaması 
</summary> </h2>

## Kurulum:
* Komutları tek tek girin.

```
sudo apt update 
```
```
sudo apt upgrade
```
```
apt install docker-compose
```
```
sudo apt-get update && sudo apt install jq && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
```

## Klonluyoruz repoyu
```
git clone https://github.com/taikoxyz/simple-taiko-node.git
cd simple-taiko-node
```
## Ayrı screende çalıştıracağız:
```
screen -S taiko
```
</details>

<details>

<summary> 
<h2> 2) RPC oluşturma ve Taiko Nodunun ayarlarını değiştirme 
</summary> </h2>

## İçine girip düzenlemeler yapıyoruz:
```
cp .env.sample .env
nano .env
```
## Bu kısıma devam etmeden önce sıfırdan metamask aç ve Api key al : [link](https://dashboard.alchemy.com/)
* Fotoğraftaki işaretlediğim yerleri takip edin. 

![image](https://user-images.githubusercontent.com/76253089/227012383-fde014d1-93a5-44a9-92d0-927a565dfbb6.png)
* İşaretlediğim yere basın ve olusturudugunuz endpointin bilgilerine erişin

![image](https://user-images.githubusercontent.com/76253089/227012695-a11a9ceb-954f-40d9-971e-3e833563a10e.png)
* Altta istenilen yerleri buradaki bilgilerini girmeniz gerekiyor.

![image](https://user-images.githubusercontent.com/76253089/227012057-33d5cf2a-a028-423b-baed-44bb22793081.png)

## Yukarıdaki komutları girince açılacak ekran görselde ki gibi.

* Açıldıktan sonra yön tuşları ile en alta geliyoruz.
* `L1_ENDPOINT_HTTP= 'Bu kısıma Alchemyden aldığınız HTTPS adresini yazıyorsunuz'
* `L1_ENDPOINT_WS= 'Bu kısıma Alchemyden aldığınız WSS adresini yazıyorsunuz'
*  L1_PROVER_PRIVATE_KEY= 'Bu kısıma Metamask Private keyinizi yapıştırıyorsunuz' 
* `ENABLE_PROPOSER` kısmını `true` yapıyoruz
* sonra CTRL + X + Y ile çıkıyoruz.

![image](https://user-images.githubusercontent.com/76253089/227011508-2772d933-500d-44c0-a7b4-8749c358f32a.png)

* Metamasktan 3 noktaya tıklayınca hesap bilgileri kısmında olacak burası:
![image](https://user-images.githubusercontent.com/101149671/212497188-e5480587-9872-4c0f-abf0-4f6b24839396.png)

</details>

<details>

<summary> 
<h2> 3) Node Çalıştırma / Diğer Komutlar
</summary> </h2>

## Node'u çalıştırın:
```
docker compose up
```
## Node'unuz çalışıyor kolay gelsin:

![image](https://user-images.githubusercontent.com/76253089/227013461-29711ddd-47ec-49fd-a881-2538aaa9062a.png)

</details>


<h2> Kaç blok bulduğunuzu görüntülemek için explorerda cüzdan adresinizi aratın https://explorer.a2.taiko.xyz/ </h2>
