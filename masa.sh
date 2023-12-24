#!/bin/bash

function colors {
  GREEN="\e[32m"
  RED="\e[39m"
  YELLOW="\e[33m"
  NORMAL="\e[0m"
}

function logo {
  curl -s https://raw.githubusercontent.com/cryptevodao/NodeMasa/main/logo.sh | bash
}

function line {
  echo -e "${GREEN}-----------------------------------------------------------------------------${NORMAL}"
}


function install_go {
    bash <(curl -s https://github.com/cryptevodao/NodeMasa/blob/main/go.sh)
    source $HOME/.profile
    sleep 1
}

function source_build_git {
    cd $HOME
    rm -rf masa-oracle-go-testnet
    git clone https://github.com/masa-finance/masa-oracle-go-testnet.git
    cd masa-oracle-go-testnet

    go build -v -o masa-node ./cmd/masa-node
    sleep 1
}

function systemd {
    sudo tee /etc/systemd/system/masad.service > /dev/null << EOF
[Unit]
Description=Masa node service
After=network-online.target

[Service]
Type=simple
User=$USER
WorkingDirectory=/root/masa-oracle-go-testnet/
ExecStart=/root/masa-oracle-go-testnet/masa-node --bootnodes=/ip4/35.224.231.145/udp/4001/quic-v1/p2p/16Uiu2HAm47nBiewWLLzCREtY8vwPQtr5jTqyrEoUo6WnngwhsQuR,/ip4/104.198.43.138/udp/4001/quic-v1/p2p/16Uiu2HAkxiP8jjdHQWeCxTr7pD6BvoPkS8Z1skjCy9vdSRMACDcc,/ip4/35.202.227.74/udp/4001/quic-v1/p2p/16Uiu2HAmHuUejpUBFPCxy32QhGRAbv3tFwbzXmLkCoaNcZTyWWqN,/ip4/10.128.0.47/udp/4001/quic-v1/p2p/16Uiu2HAkxiP8jjdHQWeCxTr7pD6BvoPkS8Z1skjCy9vdSRMACDcc,/ip4/107.223.13.174/udp/4001/quic-v1/p2p/16Uiu2HAm2uQ5TGviRkqhYMpg7fjeoB4TfpSAhrbY87YZ4h9jYCNm,/ip4/34.171.201.124/udp/4001/quic-v1/p2p/16Uiu2HAmCKzfsynicpryPZTdcJsjmyzXn8tA13zMHHsoBxLdvVCE,/ip4/34.132.48.64/udp/4001/quic-v1/p2p/16Uiu2HAmNk4DDNiVu8ipN2cg5GLpGzN6ydd4EYps1NkiTDBRkctu --port=4001 --udp=true --start=true
Restart=on-failure
RestartSec=10
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable masad
}

function start {
    sudo systemctl start masad
}

function main {
    colors
    line
    logo
    line
    get_nodename
    line
    install_go
    source_build_git
    line
    systemd
    line
}

main