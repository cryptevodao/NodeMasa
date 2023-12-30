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

## Issues

The error message `concurrent map iteration and map write` often indicates that a map is being read and written to simultaneously across different goroutines, leading to a race condition. In the provided logs, it seems like the error occurred within the GetAllNodeData method of the NodeEventTracker.

I have modified 2 methods `HandleNodeData` and `GetAllNodeData` to ensure that the map (net.nodeData) is not modified while it's being iterated over. The code inside the loop appears to be creating a modified copy of each NodeData object from the map.

To fix the issue, follow the steps below:

1. Stop the service 
```bash
sudo systemctl stop masad
```

2. Run the follow code to download the fixed file `node_event_tracker.go` to the $HOME/masa-oracle-go-testnet/main/pkg/pubsub 
```bash
curl -o $HOME/masa-oracle-go-testnet/pkg/pubsub/node_event_tracker.go -L https://raw.githubusercontent.com/cryptevodao/NodeMasa/master/fix/node_event_tracker.go
```
3. Rebuld the project 
```bash
go build -a -v -o masa-node ./cmd/masa-node
```

4. Restart the service 
```bash
sudo systemctl restart masad
```
