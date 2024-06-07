- Tracks gas hatasına dusunce rollback yapmayı getirmişler geçici bir çözüm sıkıntıyı tamamıyla çözmeleri gerekıyor şimdilik böyle idare edicez. tx screeninie girip ctrl c ile durdurun

```
cd
```
```
rm -rf tracks
```
```
wget http://37.120.189.81/airchain_testnet/tracks
```
```
chmod +x tracks
```
```
systemctl stop tracksd
```
```
./tracks rollback
```
```
./tracks start
```
- hata verirse ctrl c ile durdur rolback komutunu 2 3 defa deneyip podu 2 3 geri alıp start komutuyla tekrar deneyin. sıkıntı olmassa ctrl c ile durdurup servis oalrak tekrar çalıştırırsınız.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/49d17da0-a11c-466c-9cb7-3989016ffacc)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/eb04a78a-395d-4d7f-ba6c-c5bcea84c748)

