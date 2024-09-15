#!/bin/bash
URL="https://github.com/mikeesierrah/ez-backhaul/raw/main/ez-backhaul.sh.enc"

echo "Downloading and decrypting the script..."
curl -Ls "$URL" | openssl enc -aes-256-cbc -d -pass pass:"$(read -sp 'Enter decryption password: ' PASSWORD && echo $PASSWORD)" | bash
if [ $? -ne 0 ]; then
    echo "Failed to decrypt or execute the script."
    exit 1
fi
