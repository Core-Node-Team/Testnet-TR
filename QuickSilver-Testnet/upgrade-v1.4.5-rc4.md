cd $HOME
wget -O quicksilverd https://github.com/ingenuity-build/quicksilver/releases/download/v1.4.5-rc4/quicksilverd-v1.4.5-rc4-amd64
chmod +x $HOME/quicksilverd
sha256sum $HOME/quicksilverd
echo checksum 0a9ee6a5e5dc19bebe29483c8bad166ee5ae12ab686bbe4a0a2f282cf9105116
sleep 3
sudo mv $HOME/quicksilverd $(which quicksilverd)
sudo systemctl restart quicksilverd && sudo journalctl -u quicksilverd -f
