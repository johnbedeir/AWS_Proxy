#!/bin/bash
set -euo pipefail
dnf install -y nodejs

mkdir -p /opt/app
cat >/opt/app/app.js <<'APPJS'
const http = require("http");

http
  .createServer((req, res) => {
    res.writeHead(200);
    res.end("Hello from private backend\n");
  })
  .listen(3000, "0.0.0.0");
APPJS

cat >/etc/systemd/system/private-backend.service <<'UNIT'
[Unit]
Description=Private Node backend
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/node /opt/app/app.js
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
UNIT

systemctl daemon-reload
systemctl enable --now private-backend.service
