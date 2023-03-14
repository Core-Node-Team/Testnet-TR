## ***Arkadaşlar Naruna Baklava Testneti için başvuru yapanlar arasından seçilelere mail geldi. İlerleyen günlerde başlayacak olan testnete katılmak için cüzdan oluşturmak gerekiyor.***
## ***Gelen maile oluşturduğumuz cüzdan adresi ile discord kullanıcı adımızı yanıt göndermemiz isteniyor***




# Öncelikle güncellemeler ve Kütüphaneler
```
sudo apt-get update && sudo apt-get upgrade -y

apt install ca-certificates curl gnupg lsb-release git htop python3
```
# PIP kurulumu yapıyoruz
```
wget https://bootstrap.pypa.io/get-pip.py

python3 get-pip.py
```
# Naruno repo klonlayıp kurulumu yapıyoruz
```
git clone https://github.com/Naruno/Naruno.git

cd Naruno

pip install naruno
```
# Cüzdan oluşturma

>  ***`<ŞİFRE>`*** yazan yere bir şifre belirleyin ama unutmayın yoksa walleti açamazsınız.
```
narunocli --createwallet <ŞİFRE>


narunocli --printwallet
``` 
![image](https://user-images.githubusercontent.com/108215275/224547775-81190875-f7c7-4b55-b4ad-f76426f4d950.png)

> ## ***`--printwallet`*** komutundan sonra görünen iki cüzdan adresinden ikincisini mail ile göndermeniz gerekiyor, kızmızı ile işaretli


# Cüzdan yedeğini almak
```
narunocli --narunoexport
```

## Ardından sunucuda `/usr/local/lib/python3.8/dist-packages/naruno/backups/` altındaki .zip dosyasını indirip yedek alabilirsiniz

## Başka bir sunucuya taşımak isterseniz bu komutu kullanabilirsiniz
```
narunocli --narunoimport zip_dosya_yolu
```
## Zip dosyasını yeni sunucuda `/root` altına yüklediyseniz dosya yolu `/root/..dosyaismi..zip` gibi olur
