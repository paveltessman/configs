#!/bin/bash
# https://github.com/inovex/prometheus-libvirt-exporter
set -euo pipefail

if [[ -z "$1" ]]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 2.3.1"
    exit 1
fi

VERSION="$1"
NAME="prometheus-libvirt-exporter-${VERSION}.linux-amd64"
DOWNLOAD_LINK="https://github.com/inovex/prometheus-libvirt-exporter/releases/download/v${VERSION}/${NAME}.tar.gz"
TMP_DIR="${HOME}/tmp"
TAR_PATH="${TMP_DIR}/${NAME}.tar.gz"

trap 'rm -rf "${TMP_DIR}"' EXIT

function create_user() {
    sudo useradd -m libvirt_exporter 2> /dev/null
    sudo usermod -a -G libvirt_exporter libvirt_exporter 2> /dev/null
}

function download_and_extract() {
    mkdir -p "${TMP_DIR}"
    curl -L "${DOWNLOAD_LINK}" -o "${TAR_PATH}"
    tar -xvf "${TAR_PATH}" -C "${TMP_DIR}"
    sudo mv "${TMP_DIR}/${NAME}/prometheus-libvirt-exporter" "/usr/local/bin/prometheus-libvirt-exporter"
    sudo chown libvirt_exporter:libvirt_exporter /usr/local/bin/prometheus-libvirt-exporter
}

function create_service() {
    sudo bash -c 'cat <<EOF > /etc/systemd/system/prometheus-libvirt-exporter.service
[Unit]
Description=Prometheus Libvirt Exporter
After=network.target

[Service]
User=libvirt_exporter
Group=libvirt_exporter
Type=simple
ExecStart=/usr/local/bin/prometheus-libvirt-exporter

[Install]
WantedBy=multi-user.target
EOF'

    sudo systemctl daemon-reload
    sudo systemctl start prometheus-libvirt-exporter
    systemctl status prometheus-libvirt-exporter
}

function main() {
    create_user
    download_and_extract
    create_service
}

main
