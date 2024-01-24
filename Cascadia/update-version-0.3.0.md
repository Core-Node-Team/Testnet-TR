cd $HOME
rm -rf cascadia
git clone https://github.com/cascadiafoundation/cascadia
cd cascadia
git checkout v0.3.0
make build
sudo mv $HOME/cascadia/build/cascadiad $(which cascadiad)
sudo systemctl restart cascadiad && sudo journalctl -u cascadiad -f
