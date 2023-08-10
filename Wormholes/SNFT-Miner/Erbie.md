![DSDSD](https://github.com/molla202/Erbie/assets/91562185/ebcb952c-b0f0-44ee-9a8f-9ec26daaca24)


 * [Topluluk kanalımız](https://t.me/corenodechat)<br>
 * [Topluluk Twitter](https://twitter.com/corenodeHQ)<br>

## Eskisini silmek için.
```
docker stop wormholes && docker rm wormholes && docker rmi wormholestech/wormholes:v1
rm -rf /wm
```
## Sistem Gereksinimleri
| Bileşenler | Minimum Gereksinimler | 
| ------------ | ------------ |
| CPU |	4|
| RAM	| 8+ GB |
| Storage	| 500 GB SSD |

## Update edelim
```bash
sudo apt update; sudo apt upgrade 
```
## Docker kurulumu
```bash
sudo apt-get install wget && sudo apt-get update && sudo apt install jq git && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin 

```
## Erbie Kurulum
```
wget -O erbie_install.sh https://docker.erbie.io/erbie_install.sh && sudo bash erbie_install.sh
```

👉 Private keyimizi girelim.

![image](https://github.com/molla202/Erbie/assets/91562185/98bf6fcc-67c6-4470-84ba-b4ac3298d470)

👉Kurulum bittikten sonra çıktımız.

![image](https://github.com/molla202/Erbie/assets/91562185/28e40ee6-0bfa-485c-a7f2-71aebdfa27bf)

👉 docker ps -a diyoruz ve status kısmında çalıştığını teyit ediyoruz. unutmayın 8545 portunu kullanıyoruz bu yuzden baska bişi kullanmadığındna emin olunuz.

![image](https://github.com/molla202/Erbie/assets/91562185/7f47a89c-f9c6-4139-843a-e7686606688b)

--------------------



👉Bağlantı durumu kontrol.
```
curl -X POST -H 'Content-Type:application/json' --data '{"jsonrpc":"2.0","method":"net_peerCount","id":1}' http://127.0.0.1:8545
```
👉Blok kontrolu
```
curl -X POST -H 'Content-Type:application/json' --data '{"jsonrpc":"2.0","method":"eth_blockNumber","id":1}' http://127.0.0.1:8545
```
👉Bakiye kontrol

- Cüzdan adresi yazınız kısmına adresini yazınız.
```
curl -X POST -H 'Content-Type:application/json' --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["cüzdan-adresi-yazınız","pending"],"id":1}' http://127.0.0.1:8545
```
👉Versiyon kontrol
```
curl -X POST -H "Content-Type:application/json" --data '{"jsonrpc":"2.0","method":"eth_version","id":64}' http://127.0.0.1:8545
```


👉Monitor yükleme.
```
nano monitor.sh
```
- içine aşağıdaki kodu kopyalayalım. ctrl+x y deyip kaydedelim.
```
#!/bin/bash
function info(){
   cn=0
   vl=$(wget https://docker.erbie.io/version>/dev/null 2>&1 && cat version|awk '{print $2}')
   while true
   do
            echo "the monitor version is $vl"
            echo "$cn second."
            echo "node $1"
            rs1=`curl -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"net_peerCount","id":64}' 127.0.0.1:$1 2>/dev/null`
            count=$(parse_json $rs1 "result")
            echo "Number of node connections: $((16#${count:2}))"
            rs2=`curl -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","id":64}' 127.0.0.1:$1 2>/dev/null`
            blckNumber=$(parse_json $rs2 "result")
            echo "Block height of the current peer: $((16#${blckNumber:2}))"
            sleep 5
            clear
            let cn+=5
   done
}

function parse_json(){
   echo "${1//\"/}"|sed "s/.*$2:\([^,}]*\).*/\1/"
}

function main(){
   if [[ $# -eq 0 ]];then
            info 8545
   else
            info $1
   fi
}

main "$@"
```

## Monitor çalıştıralım.
```
bash ./monitor.sh
```
