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
wget https://files.elixir.finance/Dockerfile
```
- Düzenliyoruz
```
nano Dockerfile
```
Not: alttaki çıktı için yeni bir mm adresi olusturun goerli eth faucet bulun... gerekli olanalrı yazıp ctrl x y enterla kaydedip çıkın.

ENV ADDRESS=metamask adresi
ENV PRIVATE_KEY=private key
ENV VALIDATOR_NAME=discord adı

### Güncel image çekip Çalıştıralım
```
docker build . -f Dockerfile -t elixir-validator
docker pull elixirprotocol/validator:testnet-2
docker run -d --restart unless-stopped --name ev elixir-validator
```
### Log kontrol
Not: `docker ps` yazıp container numarasını öğrenelim
```
docker logs container-name -f
```
### Platform üzerinden işlemler

- Siteye gidiyoruz
 
https://dashboard.elixir.finance/

- Elixir claimliyoruz

![image](https://github.com/molla202/Elixir/assets/91562185/e13722d8-fc45-4428-a48e-877298bc5592)

- Stake ediyoruz
- Sonra enroll diyoruz.

![image](https://github.com/molla202/Elixir/assets/91562185/baf5f2b9-d5f3-4ce4-9ff5-138a63be2569)

- Twitter bağlıyoruz. discord adımızı yazıp rolümüzü claimliyoruz.

![image](https://github.com/molla202/Elixir/assets/91562185/53cdc0e9-830d-451e-b223-9661281bcc6b)



