# Elixir
![image](https://github.com/molla202/Elixir/assets/91562185/99389634-3672-4d63-bd45-2f45533c38b6)

### Update
```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
```

# Docker kurulumu
```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt-get update
```
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


### Dockerfile çekiyoruz

```
nano validator.env
```
Not: alttakileri düzenle yapıstır ctrl xy enterla kaydet çık. eskiden katıldıysan o cüzdanı kullanabilirsin(sormadan söyleyim :D). evet evet daha iyi olur.
```
ENV=testnet-3

STRATEGY_EXECUTOR_IP_ADDRESS=sunucu-ip-yaz
STRATEGY_EXECUTOR_DISPLAY_NAME=vali-adi-yaz
STRATEGY_EXECUTOR_BENEFICIARY=cüzdan-adresi-yaz
SIGNER_PRIVATE_KEY=private-key-yaz
```
### Güncel image çekip Çalıştıralım
```
docker pull elixirprotocol/validator:testnet-3
```
```
docker run -d \
  --env-file /root/validator.env \
  --name elixir \
  --restart unless-stopped \
  elixirprotocol/validator:v3
```
### Log kontrol
```
docker logs -f --tail 100 ev
```
### Platform üzerinden işlemler

- Siteye gidiyoruz
 
https://dashboard.elixir.finance/

- mock mintliyoruz.

![image](https://github.com/user-attachments/assets/372d88f9-4764-4edb-9d67-b3970853611d)

![image](https://github.com/user-attachments/assets/a8df72f0-609a-4bd1-84da-dcd51b6206aa)

- Stake ediyoruz

![image](https://github.com/user-attachments/assets/29154f78-0b07-4cd8-8bbb-7d0ec8963e3f)


- şimdide custom validator yazısına tıklayıp cüzdan adresimizi yazalım. ve delegate deyip cüzdandna onaylayalım.

![image](https://github.com/user-attachments/assets/66ac61b9-9bf2-4641-8ed0-8220630ad5b7)


![image](https://github.com/user-attachments/assets/f0845b42-b7fc-4d27-83dc-668cf8ae60c5)

- azbi zaman sona

![image](https://github.com/user-attachments/assets/2570ca14-5efc-422c-ad99-6b81dbf5ee97)




