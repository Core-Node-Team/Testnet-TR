
### 8.606.342 Block

- Launcher çalıştırın. kurulumu yapın loglar akmaya baslayınca sycn olurken durdurun log kısmından. sonra aşağıdaki işlemi yapın ve start deyin. bu hizmetide corenode dan baskası yapmaz :D
```
rm -rf /root/.humanode/workspaces/default/substrate-data/chains/humanode_mainnet/db/full
curl -L http://37.120.189.81/humanode/full.tar.gz | tar -xz -C /root/.humanode/workspaces/default/substrate-data/chains/humanode_mainnet/db/
```
