pk=$1
bn=$2

geth init --datadir data genesis.json

geth --datadir data \
  --networkid 123321 \
  --unlock "$pk" \
  --password "/dev/null" \
  --bootnodes "$bn" \
  --mine
