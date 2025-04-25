
```
docker stop analog
docker rm analog
rm -rf /root/.analog/chains/anlogcc1/paritydb/full
curl -L https://analog-public.s3.amazonaws.com/backup/testnet-backup.tar.gz | tar -xz -C /root/.analog
```
NOT: corenode yazısını kendi isiminizle değiştirin
```
docker run -d -p 9947:9944 -p 30303:30303 \
-v $(pwd)/.analog:/.analog --name analog analoglabs/timechain \
--base-path /.analog --rpc-external --rpc-methods=Unsafe --unsafe-rpc-external --rpc-cors=all \
--name corenode --telemetry-url "wss://telemetry.analog.one/submit 0" --sync warp \
--reserved-nodes /ip4/81.0.221.49/tcp/30303/p2p/12D3KooWNuyqn4CzbcKEirjzgE5HH3XZeZ7rxy5i5eTwj44rLfkF \
--reserved-nodes /ip4/84.247.174.6/tcp/30303/p2p/12D3KooWNYFb7SGDkH7asQsjHcy5D3ffe3BxAH1mGY77Wkke6WnQ
```
```
docker logs -f analog -n 100
```
