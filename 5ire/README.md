<h1 align="center"> 5ire REHBERİ </h1>
<div align="center">
</div>

## Ovpn Client oluşturma, Ovpn ile explorer bağlanma, Cüzdan oluşturma swap ve transfer & Node kurma & Kontrat oluşturma.

![image](https://user-images.githubusercontent.com/76253089/209724364-5059536c-bce0-4f9c-af58-8ca73deae445.png)

Eğer mailiniz geldiyse bu rehberi kullanarak node kurup kontrat oluşturmaya başlayabilirsiniz. <br> Öncelikle OVPN kurulumundan başlayacağız sonrasında içine client dosyamızı atacağız ve mailinize gelen bağlantıları açıp cüzdan oluşturma, trasfer, swap gibi adımları yapacağız. Dikkatli okuyun bazı adımlar karışık, Başlayalım. Hangi adımda kaldıysanız ordan devam edin.

1. Gelen maildeki şifre ile OVPN Client Oluşturma.
2. OVPN kurulum ve oluşturulan Cliente Bağlama.
3. Cüzdan oluşturma & Swap & Transfer & Metamask'a Eklemek.
4. Node Kurma Aşaması.
5. Contrat oluşturma ve etkileşime geçme.


## Full Node için <br> Minimum Sistem Gereksinimleri <br>
Çekirdek: 4 <br>
Bellek : 8 GB <br>
Depolama : 100GB SSD

Önerilen  <br>
Çekirdek: 8 <br>
Bellek : 16 GB <br>
Depolama : 100GB SSD 

<details>

<summary> 
<h2> 1.) Gelen Maildeki Şifre ile OVPN Client Oluşturma. 
</summary> </h2>

Gelen Maildeki ilk linke tıklayalım ve rehberde verilen siteye giriş yapalım. [Link](https://ovpn.5ire.network:943)

<img src="https://user-images.githubusercontent.com/76253089/209724502-e6241f31-69e1-4878-8f94-8dd3f49e9057.png" align="center" height="600" width="500" />    

Açılan sayfada Mailinizde verilen bilgileri girin ve giriş yapın.

![Screenshot_3](https://user-images.githubusercontent.com/76253089/210077847-a74446e1-20af-423f-aca2-6d32c130de7a.png)

Sonrasında sizden 2FA uygulaması kurmanızı istiyor. Google Auth kullanıp verdiği QR kodunu okutun ve ayarlamanızı yapın.

![photo_2023-01-01_18-24-04](https://user-images.githubusercontent.com/76253089/210176043-8836b083-889f-41db-86e1-8dd6c9803621.jpg)

Şimdi ise clienti indirmemiz gerekiyor işaretlediğim yere tıklayıp clienti indirin.

![image](https://user-images.githubusercontent.com/76253089/210176086-ce43500c-b76d-4b19-9211-48832bf43211.png)

Client oluşturma tamamdır bir sonraki adıma geçin.
</details>

<details>

<summary> 
<h2> 2.) OVPN kurulum ve oluşturulan Cliente Bağlama. 
</summary> </h2>

[OVPN Indirme Linki](https://openvpn.net/community-downloads/) Burdan OVPN 2.5.8 olanı indirin. <br>
Uygulamayı açın, açtıktan sonra küçültülmüş olarak açılacaktır. Aşağıdaki görselden sırasıyla işaretlediklerime basın ve oluşturduğunuz clienti OVPN içine aktarın ve bağlanın.

![image](https://user-images.githubusercontent.com/76253089/210079192-6d108d75-bf58-4455-ac4f-fbb895c9fba2.png)

Sonraki aşamaya geçin.
  
</details>

<details>

<summary> 
<h2> 3.) Cüzdan oluşturma & Swap & Transfer & Metamask'a Eklemek. 
</summary> </h2>
 
Mailde verilen diğer link olan explorer sitesine giriş yapacağız (OVPN bağlantısı açık olmazsa Access Denied hatası alırsınız. Cliente bağlandığınıza emin olun.) <br>
[Explorer Linki](https://explorer.5ire.network/)

Cüzdan oluşturup kesinlikle not edin, vpn bağlantısını kestiğinizde cüzdan siliniyor mnemonicleri tekrar girmeniz gerekiyor. <br>
Sağdan wallet kısmına basıp Create new wallete basın.

![image](https://user-images.githubusercontent.com/76253089/210079969-704af0e1-3e76-418b-aaad-2083796f8c68.png)

Sonra swap ve transfer işlemleri yapın, Aynı işlemleri Metamask kısmında da yapmamız gerekiyor, önce explorer üzerinden yapalım. Adresime gönderim yapabilirsiniz. <br>
`EVM Chain Address: (Metamask)
0xcf42d1D77912240Ce805f102E6158eF25f91619a
`
<br>
`
Native Chain Address: (Explorerdeki)
5EDM8ZQaqdZiNsf4RP2qbZrTpgsRmswD3hRqs8tFQnHFnrAH
`

Şimdi Metamask kısmına geçelim önce Ağı Manuel olarak Metamaska eklememiz lazım alttaki bilgileri girin.

`
Network Name: 5ireChain
`
<br>
`
New RPC Url: https://chain-node.5ire.network
`
<br>
`
Chain ID: 997
`
<br>
`
Currency Symbol: 5ire
`
<br>
`
Explorer URL: https://explorer.5ire.network
`
<br>

Cüzdanınızı metamaskta import edin ve üstteki cüzdana bi kaç token transfer edin. İşlem bu kadar Diğer aşamaya geçin.

</details>

<details>

<summary> 
<h2> 4.) Node Kurma Aşaması.
</summary> </h2>

## Önce Sunucumuzu Güncelleyelim
```
sudo apt update && sudo apt upgrade
```
## Docker'ı kuralım
```
apt install docker.io
```
## Screen oluştur
```
screen -S 5ire
```
## Full Düğümü kuralım alttaki NODEISMI yazan kısma istediğiniz bi kelimeyi girin.
```
docker run -p 30333:30333 -p 9933:9933 -p 9944:9944 5irechain/5ire-thunder-node:0.10 --port 30333  --ws-external --ws-port 9944 --rpc-external --rpc-port 9933 --rpc-cors all --no-telemetry --name NODEISMI --bootnodes /ip4/3.19.122.7/tcp/30333/p2p/12D3KooWNLQPtTkKwapACfMas7vyM4gujwnevxfgXUyTGno3bDpY --pruning archive
```
## Tamamdır işlem bu kadar sync olduktan sonra blok işlemeya başlayacaktır
![image](https://user-images.githubusercontent.com/76253089/210086721-eb1d446e-241f-41c6-9b87-d182c9d5efc2.png)

</details>

<details>

<summary> 
<h2> 5.) Contrat oluşturma ve etkileşime geçme. 
</summary> </h2>
Aslında 2 yöntem var ama ben sadece 1. yöntemi anlatıcam. Diğer yöntemi merak edenler ekibin paylaştığı makaleden okuyabilir alt kısımda bırakıcam.

Remix kullanarak bu işlemi yapıcaz biraz karışık gelebilir işaretlediğim yerleri sırasıyla yapmaya özen gösterin.

Remix sitesine girelim [Remix Sitesi](https://remix.ethereum.org/)

İşaretlediğim yere tıklayın ve yeni dosya oluşturun. İsmini enzifiri koyalım.
![image](https://user-images.githubusercontent.com/76253089/210087536-d8396e24-95fb-4222-9d4d-7945febc20c1.png)

Şimdi oluşturduğumuz enzifiri dosyasına alttaki komutu kopyalayıp yapıştırın. Çıkan uyarıya ok diyip kapayın.
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol
interface IERC20 {
   function totalSupply() external view returns (uint);
 
   function balanceOf(address account) external view returns (uint);
 
   function transfer(address recipient, uint amount) external returns (bool);
 
   function allowance(address owner, address spender) external view returns (uint);
 
   function approve(address spender, uint amount) external returns (bool);
 
   function transferFrom(
       address sender,
       address recipient,
       uint amount
   ) external returns (bool);
 
   event Transfer(address indexed from, address indexed to, uint value);
   event Approval(address indexed owner, address indexed spender, uint value);
}
 
 
 
contract ERC20 is IERC20 {
   uint public totalSupply;
   mapping(address => uint) public balanceOf;
   mapping(address => mapping(address => uint)) public allowance;
   string public name = "Solidity by Example";
   string public symbol = "SOLBYEX";
   uint8 public decimals = 18;
 
   function transfer(address recipient, uint amount) external returns (bool) {
       balanceOf[msg.sender] -= amount;
       balanceOf[recipient] += amount;
       emit Transfer(msg.sender, recipient, amount);
       return true;
   }
 
   function approve(address spender, uint amount) external returns (bool) {
       allowance[msg.sender][spender] = amount;
       emit Approval(msg.sender, spender, amount);
       return true;
   }
 
   function transferFrom(
       address sender,
       address recipient,
       uint amount
   ) external returns (bool) {
       allowance[sender][msg.sender] -= amount;
       balanceOf[sender] -= amount;
       balanceOf[recipient] += amount;
       emit Transfer(sender, recipient, amount);
       return true;
   }
 
   function mint(uint amount) external {
       balanceOf[msg.sender] += amount;
       totalSupply += amount;
       emit Transfer(address(0), msg.sender, amount);
   }
 
   function burn(uint amount) external {
       balanceOf[msg.sender] -= amount;
       totalSupply -= amount;
       emit Transfer(msg.sender, address(0), amount);
   }
}
```
Şimdi dosyamızı Compile edeceğiz. İşaretlediğim yerlere sırasıyla basın.
![image](https://user-images.githubusercontent.com/76253089/210088154-4fbeda9b-fb38-4c6f-aed2-a20b92b5b948.png)

Şimdi biraz kafanız karışabilir sırasıyla şunları yapalım
Soldan Deploy kısmına tıklayın (1. İşaret) <br>
Environment kısmına tıklayın ve Injected Provider - Metamask seçin ve 5ire Cüzdanınızı bağlayın. (2. İşaret) <br>
Contract kısmından ERC20 - enzifiri.sol ü seçin. (3. İşaret) <br>
Deploy tuşuna basıp kontratınızı onaylayın. (4. İşaret) <br>
![image](https://user-images.githubusercontent.com/76253089/210088468-454f2ebe-764b-4620-afea-e3ac2e0af9a0.png)

Deploy edip onayladıktan sonra aşağıda Deployed Contrat bölümü oluşacak ordan devam edeceğiz. <br>
Öncelikle Mint kısmına 100000 yazıp Mint butonuna basın ve metamasktaki işlemi onaylayın. <br>
Sonra Burn kısmına 10 yazıp Burn butonuna basıp metamasktaki işlemi onaylayın. <br>
Dilerseniz transfer kısmından bana ya da başkasına transfer edip gönderim yapabilirsiniz. 
  
`
EVM Adresim: 0xcf42d1D77912240Ce805f102E6158eF25f91619a
`
  
![image](https://user-images.githubusercontent.com/76253089/210088621-76b557d1-9206-40fe-80f0-49c5ea09c31e.png)

</details>

<h2> İşlemler bu kadardı </h2>

[5ire Website](https://www.5ire.org/) <br>
[5ire Twitter](https://twitter.com/5ireChain) <br>
[5ire Discord](https://discord.gg/5ire) <br>
[Ekibin Makalesi](https://docs.5ire.org/docs/system-admin/intro) <br>
