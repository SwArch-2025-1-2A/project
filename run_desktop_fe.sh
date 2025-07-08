#!/bin/bash

echo "Setting up the execution of the desktop frontend"

sudo cp mu_desktop_rp/certs/certificado.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

sudo apt update
sudo apt install -y \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libxss1 libasound2 \
    libxcomposite1 libxrandr2 libxdamage1 libgtk-3-0 libx11-xcb1 \
    libxtst6 libgbm1 libxshmfence1 libxi6

cd mu_fe_superuser/ || exit 1
npm install || { echo "npm install failed"; exit 1; }
npm run build || { echo "npm run build failed"; exit 1; }

GRAPHQL_API="https://localhost:4000/query" NODE_OPTIONS=--use-openssl-ca npm run start &

echo "Starting the server"

until curl -s http://localhost:3000 > /dev/null; do
  sleep 1
done

echo "Executing Electron JS"

npx electron --no-sandbox main.cjs