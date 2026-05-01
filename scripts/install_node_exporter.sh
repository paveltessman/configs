#!/bin/bash
# THANKS TO https://jaanhio.me/blog/linux-node-exporter-setup/
set -euo pipefail

if [[ -z "$1" ]]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.9.0"
    exit 1
fi

VERSION="$1"
NAME="node_exporter-${VERSION}.linux-amd64"
DOWNLOAD_LINK="https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/${NAME}.tar.gz"
TMP_DIR="${HOME}/tmp"
TAR_PATH="${TMP_DIR}/${NAME}.tar.gz"

trap 'rm -rf "${TMP_DIR}"' EXIT

function create_user() {
    sudo useradd -m node_exporter 2> /dev/null
    sudo usermod -a -G node_exporter node_exporter 2> /dev/null
}

function download_and_extract() {
    mkdir -p "${TMP_DIR}"
    curl -L "${DOWNLOAD_LINK}" -o "${TAR_PATH}"
    tar -xvf "${TAR_PATH}" -C "${TMP_DIR}"
    sudo mv "${TMP_DIR}/${NAME}/node_exporter" "/usr/local/bin/node_exporter"
    sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
}

function create_service() {
    sudo bash -c 'cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF'

    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    systemctl status node_exporter
}

function main() {
    create_user
    download_and_extract
    create_service
}

main
