- Eğer kanal bulamıyorsanız.
- Screene girin roller durdurun
```
nano ~/.roller/relayer/config/config.yaml
```
- yukarıdaki kodla girdiğiniz yerde aşağıdakileri değiştirin gösterildiği gibi
```
min-loop-duration: 0ms -> min-loop-duration: 100ms

rule: "" -> rule: "allowlist"

channel-list: [] -> channel-list: ["channel-0", "channel-49"]
```
- Relay güncelleme
```
wget https://github.com/dymensionxyz/go-relayer/releases/download/v0.3.3-v2.5.2-relayer-rc01/Cosmos.Relayer_0.3.3-v2.5.2-relayer-rc01_linux_amd64.tar.gz

tar -xvf Cosmos.Relayer_0.3.3-v2.5.2-relayer-rc01_linux_amd64.tar.gz

mv Cosmos\ Relayer_0.3.3-v2.5.2-relayer-rc01_linux_amd64/rly /usr/local/bin/roller_bins/
```
- roller run diyerek başlatalım kısa sürede bulacaktır.
```
roller run
```
