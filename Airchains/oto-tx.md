### Oto tx

```
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
```
```
sudo apt-get install -y nodejs
```
```
sudo apt install nodejs npm
```
```
npm install web3@1.5.3
```
```
nano corenodetx.js
```
- içersine aşağıdakileri kopyalayıp yapıstırın ctrl x+y enterla kaydedip çıkın.
```
const readline = require('readline');
const Web3 = require('web3');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('MetaMask cüzdanının özel anahtarını girin: ', (privateKey) => {
  rl.question('Göndermek istediğiniz cüzdan adresini girin: ', (toAddress) => {
    rl.question('Göndermek istediğiniz miktarı girin (tevmos): ', (amount) => {
      rl.question('İşlemi kaç saniyede bir tekrar etmek istiyorsunuz? (saniye cinsinden): ', (interval) => {

        const rpcURL = "http://localhost:16545"; // veya sunucunuzun IP'si: "http://your-server-ip:16545"
        const web3 = new Web3(new Web3.providers.HttpProvider(rpcURL));

        function sendTransaction() {
          const account = web3.eth.accounts.privateKeyToAccount(privateKey);
          web3.eth.accounts.wallet.add(account);
          web3.eth.defaultAccount = account.address;

          const tx = {
            from: web3.eth.defaultAccount,
            to: toAddress,
            value: web3.utils.toWei(amount, 'ether'),
            gas: 21000,
            gasPrice: web3.utils.toWei('1', 'gwei')
          };

          web3.eth.sendTransaction(tx)
            .then(receipt => {
              console.log('Transaction successful with hash:', receipt.transactionHash);
            })
            .catch(err => {
              console.error('Error sending transaction:', err);
            });
        }

        setInterval(sendTransaction, interval * 1000);

        rl.close();
      });
    });
  });
});
```

- şimdi kodumuzu çalıştırdığımızda bizden cüzdanımızın private keyini , göndereceğimiz cüzdan adresini , miktarı , kaç saniyede bir tx atacağımızı sorucak gerekli bilgileri girince tx kasmaya başlar.
- saniyeyi az girmeyin 30 50 falan yapın çok sık işlem atarsa prof işlemi hata alıyor.
- ancak bunu screen içinde çalıştıralım screen -S tx şeklinde bir screen açalım ve öle başlatalım.
- peki hangi cüzdanın private keyi tabikide air adresimizi verdiği ve kelimeleri verdiği işlemdeki. nasıl alıcaz bunu aşağıda
```
/root/evm-station/build/station-evm keys list --keyring-backend test
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/644bfc80-3ee0-438b-854a-4c35547f4232)


- cüzdan adını öğrendik private key alalım. kodu girin yes deyin.
```
/root/evm-station/build/station-evm keys export cüzdan-adi --unarmored-hex --unsafe --keyring-backend test
```
![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/b2ae81d2-3f0a-4466-bd8a-04ad382b1cf4)

```
node corenodetx.js
```
- çalıştırdıktan sonra ctrl ad ile cıkın ve evm screenide geçip işlemler oluyormu diye bakın bazen hata verip durabilir tekrar başlatmanız gerekebilir.

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/dcd4e501-4900-4ca2-8582-f9db7760d5c6)

![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/00dd867d-a224-4858-8ae0-1798b36553fe)

