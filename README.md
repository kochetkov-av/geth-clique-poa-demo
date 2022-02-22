# Geth PoA Clique docker-compose demo

## Pre-generated artifacts

Pre-generated bootnode keys (*bootnode.key* file):

```
enode://6107c391547b8e25cf91e11c3acca3be6322356aa4f50d4eaebc118c54d4e1aaa993c850844c5bd4458e819b22d33ea18a35ecada5945763b57aceb9980690bc@127.0.0.1:0?discport=30301

Key:
93f6158b5bb789c73389995674d37a85e4e771a4e98a53852b11f8a0862be870
```

To generate new bootnode key:

```
docker-compose exec tools sh
bootnode -genkey newbootnode.key
```

Find generated bootnode key in file *newbootnode.key*

Pre-generated keys for validators:

```
Public address of the key:   0x2d558F4633FF8011C27401c0070Fd1E981770B94
Path of the secret key file: keystore/1_2d558F4633FF8011C27401c0070Fd1E981770B94.json

Public address of the key:   0x66DFE79b64F64718430ffc468806FB3E13853651
Path of the secret key file: keystore/2_66DFE79b64F64718430ffc468806FB3E13853651.json

Public address of the key:   0x388C9150daea7e36560c6A22A88D6fE7d3749845
Path of the secret key file: keystore/3_388C9150daea7e36560c6A22A88D6fE7d3749845.json
```

To generate new keystore entity:

```
docker-compose exec tools sh
geth account new --datadir data
```

find generated keystore file in */data/keystore* with name similar to
*UTC--2022-02-20T07-14-39.045409300Z--b6d6dd1a0d9bd4a424cddcefbd4cd76510ceba59*

## Adding Clique validators

Initially only first validator 0x2d558F4633FF8011C27401c0070Fd1E981770B94 is available

Propose Validator2:

```
docker-compose exec validator1 geth attach /data/geth.ipc --exec 'clique.propose("0x66DFE79b64F64718430ffc468806FB3E13853651", true)'
```

Propose Validator3:

```
docker-compose exec validator1 geth attach /data/geth.ipc --exec 'clique.propose("0x388C9150daea7e36560c6A22A88D6fE7d3749845", true)'
docker-compose exec validator2 geth attach /data/geth.ipc --exec 'clique.propose("0x388C9150daea7e36560c6A22A88D6fE7d3749845", true)'
```

Check clique status and signers with node:

```
docker-compose exec node geth attach /data/geth.ipc --exec 'clique.status()'
docker-compose exec node geth attach /data/geth.ipc --exec 'clique.getSigners()'
```

Send 5 ETH to test account:
```
docker-compose exec validator1 geth attach /data/geth.ipc --exec 'eth.sendTransaction({from: "0x2d558F4633FF8011C27401c0070Fd1E981770B94",to: "0x71f9BE88bE65aaa703918b0a09f84D4b015A1bc8", value: "5000000000000000000"})'
```

## Test smart contract deploy and interactions with [web3.py](https://github.com/ethereum/web3.py):

Test account Address / PK with balance from genesis block:

```
0x71f9BE88bE65aaa703918b0a09f84D4b015A1bc8
f9142d980d23838d6c309b324ff417970e8229189405379b6a7e6dfe0df0263c
```

Install web3:

```
pip3 install web3
```

Get last block info:

```
python3 interactions/info.py
```

Deploy storage smart contract:

```
python3 interactions/deploy.py
```

Retrieve and store value:

```
python3 interactions/retrieve_store.py
```
