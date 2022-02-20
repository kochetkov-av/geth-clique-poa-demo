bn=$1

geth init --datadir data genesis.json

geth --datadir data \
  --http --http.addr '0.0.0.0' --http.port 8545 --http.corsdomain '*' --http.api 'admin,debug,web3,eth,txpool,personal,clique,miner,net' \
  --networkid 123321 \
  --bootnodes "$bn"
