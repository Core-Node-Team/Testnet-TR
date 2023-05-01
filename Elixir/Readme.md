<h1 align="center"> Elixir </h1>
<div align="center">


![image](https://user-images.githubusercontent.com/108215275/235464900-033b50b2-1778-4d65-b0d8-a53b13fd6e8a.png)


# Elixir Sosyal Medya: [Twitter](https://twitter.com/ElixirProtocol)|[Discord](https://discord.gg/TKyV3nMt)|[Telegram](https://t.me/elixirprotocol)|[Docs](https://docs.elixir.finance/)

</div>


## Gereksinimler:
> ### 2CPU 4GB RAM 30GB SSD
> ### Bir metamask cüzdanı. Sadece burada kullanmak için yeni bir metamask oluşturun
> ### Goerli ağında ETH
## Güncelleme ve Kütüphaneler
```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
## Docker
```
sudo apt-get update && sudo apt install jq && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
```
## Validatör DockerFile 
```
wget https://files.elixir.finance/Dockerfile
```
### Dosyanın içine girin
```
nano Dockerfile
```
> ### `ENV ADDRESS` karşısına metamask adresinizi, `ENV PRIVATE_KEY`karşısına bu cüzdanın private keyini, `ENV VALIDATOR_NAME` karşısına validatörünüz için belirlediğiniz ismi girin.
> ![image](https://user-images.githubusercontent.com/108215275/235474096-6d832a60-2699-44a6-b8b6-dec34819042a.png)
> ### Görseldeki gibi başka bir şey eklemeyin. Validatör isminde boşluk bırakmayın `=` işaretinden sonra boşluk bırakmayın
> ### **CTRL+X Y ENTER** ile kaydedip çıkış yapın

## Kurulum
```
docker build . -f Dockerfile -t elixir-validator
```
## Başlatma
```
docker run -d --restart unless-stopped --name ev elixir-validator
```
## Loglar
```
docker logs -f ev
```
### Buna benzer görünür
![image](https://user-images.githubusercontent.com/108215275/235475416-4a34aefe-0ed3-441d-b8b5-7b1e04f2fadf.png)


## Cüzdanınızı Validatör Olarak Kaydedin
> ### [Siteye](https://dashboard.elixir.finance/) gidin.
> ### Node içinde kullandığınız metamaskı bağlayın
> ### Sağ üstten `claim 1000 ELXR` ile fauceti kullanın
> ### `0xb6806650A5345DA2A7C119648944A52e7faA0eb1` bu token contractını metamaskınıza ekleyebilirsiniz.
> ### Sağ üstten `stake` butonuna tıklayın. 100-1000 arası ELXR stake edin.
> ### Ardından yine sağ üstten `enroll` yapın.
> ### Transaction tamamladıktan sonra sitede üstten **Leaderboard** kısmında cüzdan adresinizi aratın görünüyorsa okay.

#
#










<div align="center">

# Core Node Sosyal Medya [Twitter](https://twitter.com/corenodeHQ)|[Discord](https://discord.gg/fzzUAU9k)|[Telegram](https://t.me/corenodechat)

![image](https://user-images.githubusercontent.com/108215275/230776662-b35d69ab-f3a2-4c4b-975f-f36dd7c1d2db.png)

### Sorularınız olursa telegram sohbet grubumuz ve discord sunucumuza katılabilirsiniz.


</div>
