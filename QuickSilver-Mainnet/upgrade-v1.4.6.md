### manuel

cd $HOME
wget -O quicksilverd https://github.com/ingenuity-build/quicksilver/releases/download/v1.4.6/quicksilverd-v1.4.6-amd64
mv quicksilverd-v1.4.6-amd64 quicksilverd
chmod +x quicksilverd
sudo mv $HOME/quicksilverd $(which quicksilverd)
sudo systemctl restart quicksilverd && sudo journalctl -u quicksilverd -f


### Cosmovisor

cd $HOME
rm -rf quicksilver
git clone https://github.com/ingenuity-build/quicksilver.git
cd quicksilver
git checkout v1.4.6

# Build binaries
make build

# Prepare binaries for Cosmovisor
mkdir -p $HOME/.quicksilverd/cosmovisor/upgrades/v1.4.6/bin
mv build/quicksilverd $HOME/.quicksilverd/cosmovisor/upgrades/v1.4.6/bin/
rm -rf build
