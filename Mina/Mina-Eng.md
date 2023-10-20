![image](https://github.com/Core-Node-Team/Testnet-TR/assets/91562185/42bd08c8-a812-4a31-beaf-ecfaa698e94e)

NOT: Need ubuntu 20
```
sudo ufw allow 22
sudo ufw allow 8301
sudo ufw allow 3089
```

### Mina
```
sudo rm /etc/apt/sources.list.d/mina*.list
echo "deb [trusted=yes] http://packages.o1test.net/ focal rampup" | sudo tee /etc/apt/sources.list.d/mina-rampup.list
sudo apt-get update
```
```
sudo apt-get install -y mina-berkeley=2.0.0rampup5-55b7818
```



* Download the zip file from the e-mail to your PC and open it hebelehübele.zip
* We create a keys file on the server ~/keys .
```
mkdir ~/keys
```
*	We edit the authority of the file
```
chmod 700 ~/keys
```
* We organize the inside of my-wallet with Nano
```
nano ~/keys/my-wallet
```
* We copy the contents of community-216-key. Open the file you downloaded with a text document
*	ctrl x +y enter
*	Let's edit the authorization of the wallet file
```
chmod 600 ~/keys/my-wallet
```
*	 We edit the my-wallet.pub file with nano, then we download it to our PC and copy the contents of community-216.pub in the file we opened and save it with ctrl x y.
```
nano ~/keys/my-wallet.pub
```
### Manuel setup



Not: You can find the password for your new wallet in the community-216-password.txt file you extracted. You will write this password below where it says `MINA_PRIVKEY_PASS="password"`. Save with ctrl x y enter. 
* You will write the password you created with the codes below `MINA_LIBP2P_PASS="password" here. So, when you enter the code, it will ask for a password, for example, you said 12345678, you will write it here `MINA_LIBP2P_PASS="password"`, now whatever password you put.
* UPTIME_PRIVKEY_PASS="password" here, write the password you wrote here MINA_PRIVKEY_PASS="password"

```
mina libp2p generate-keypair -privkey-path /root/keys/keys
```
---------------
```
nano ~/.mina-env
```

* After saying nano ~/.mina-env, copy the code below and paste it into it. Thank you, correct the corrections at the end. 
```
MINA_PRIVKEY_PASS="şifre"
UPTIME_PRIVKEY_PASS="şifre"
EXTRA_FLAGS="--log-json --log-snark-work-gossip true --internal-tracing --insecure-rest-server --log-level Debug --file-log-level Debug --config-directory /root/.mina-config/ --external-ip $(wget -qO- eth0.me) --itn-keys  f1F38+W3zLcc45fGZcAf9gsZ7o9Rh3ckqZQw6yOJiS4=,6GmWmMYv5oPwQd2xr6YArmU1YXYCAxQAxKH7aYnBdrk=,ZJDkF9EZlhcAU1jyvP3m9GbkhfYa0yPV+UdAqSamr1Q=,NW2Vis7S5G1B9g2l9cKh3shy9qkI1lvhid38763vZDU=,Cg/8l+JleVH8yNwXkoLawbfLHD93Do4KbttyBS7m9hQ= --itn-graphql-port 3089 --uptime-submitter-key  /root/keys/my-wallet --uptime-url https://block-producers-uptime-itn.minaprotocol.tools/v1/submit --metrics-port 10001 --enable-peer-exchange  true --libp2p-keypair /root/keys/keys --log-precomputed-blocks true --max-connections 200 --peer-list-url  https://storage.googleapis.com/seed-lists/testworld-2-0_seeds.txt --generate-genesis-proof  true --block-producer-key /root/keys/my-wallet --node-status-url https://nodestats-itn.minaprotocol.tools/submit/stats  --node-error-url https://nodestats-itn.minaprotocol.tools/submit/stats  --file-log-rotations 500"
RAYON_NUM_THREADS=6
MINA_LIBP2P_PASS="şifre"
```
```
chmod 600 ~/.mina-env
```

* Copy paste in one go
```
sudo tee /usr/lib/systemd/user/mina.service > /dev/null << EOF
[Unit]
[Unit]
Description=Mina Daemon Service
After=network.target
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
Environment="PEERS_LIST_URL=https://storage.googleapis.com/seed-lists/testworld-2-0_seeds.txt"
Environment="LOG_LEVEL=Info"
Environment="FILE_LOG_LEVEL=Debug"
EnvironmentFile=%h/.mina-env
Type=simple
Restart=always
RestartSec=30
ExecStart=/usr/local/bin/mina daemon --log-json --log-snark-work-gossip true --internal-tracing --insecure-rest-server --log-level Debug --file-log-level Debug --config-directory /root/.mina-config/ --external-ip $(wget -qO- eth0.me) \
--itn-keys  f1F38+W3zLcc45fGZcAf9gsZ7o9Rh3ckqZQw6yOJiS4=,6GmWmMYv5oPwQd2xr6YArmU1YXYCAxQAxKH7aYnBdrk=,ZJDkF9EZlhcAU1jyvP3m9GbkhfYa0yPV+UdAqSamr1Q=,NW2Vis7S5G1B9g2l9cKh3shy9qkI1lvhid38763vZDU=,Cg/8l+JleVH8yNwXkoLawbfLHD93Do4KbttyBS7m9hQ= \
--itn-graphql-port 3089 --uptime-submitter-key  /root/keys/my-wallet --uptime-url https://block-producers-uptime-itn.minaprotocol.tools/v1/submit --metrics-port 10001 \
--enable-peer-exchange  true --libp2p-keypair /root/keys/keys --log-precomputed-blocks true --max-connections 200 \
--peer-list-url  https://storage.googleapis.com/seed-lists/testworld-2-0_seeds.txt --generate-genesis-proof  true \
--block-producer-key /root/keys/my-wallet --node-status-url https://nodestats-itn.minaprotocol.tools/submit/stats  --node-error-url https://nodestats-itn.minaprotocol.tools/submit/stats \
--file-log-rotations 500
ExecStop=/usr/local/bin/mina client stop-daemon

[Install]
WantedBy=default.target
EOF
```
```

systemctl --user daemon-reload
systemctl --user restart mina
systemctl --user enable mina
sudo loginctl enable-linger
journalctl --user-unit mina -n 1000 -f
```

Not: Just wait a little while, it will give you this output.
```
mina client status
```







