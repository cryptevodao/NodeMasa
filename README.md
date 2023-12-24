# Masa Oracle: Install Node

Faucets: [infura](https://www.infura.io/faucet/sepolia?_ga=2.178950372.1979172489.1702899373-1520046736.1661426023) / [alchemy](https://sepoliafaucet.com/)

Form to request test $MASA - https://forms.gle/orRn9aEw68pQstCs7

### Installation

1. Prepare server, install GO and Masa node:
   ```bash
   bash <(curl -s https://raw.githubusercontent.com/cryptevodao/NodeMasa/main/masa.sh)
   ```

## Staking Tokens 🔐

To participate in the network and earn rewards, you must first stake your tokens:

1. Obtain Sepolia ETH and Masa tokens for your node's Ethereum address. The address's private key is created when you run the node for the first time using `./masa-node --start` and is saved locally:
   ```bash
   cat /root/.masa/masa_oracle_key.ecdsa
   ```

2. Import the private key into Metamask to access your Ethereum address.

3. Send Sepolia ETH and Masa testnet tokens to your address. Then you can stake!:
   ```bash
   ./masa-node --stake 100
   ```

## Running the Node 🚀

Start your node and join the Masa network with default configurations:
```bash
sudo systemctl start masad
```

Check logs:
```bash
sudo journalctl -u masad -f --no-hostname -o cat
```

## Track on Dune

https://dune.com/masa-network/masa

Check your PeerId:
```bash
cat /root/.masa/masa_oracle_node_output.env
```
Last variable


