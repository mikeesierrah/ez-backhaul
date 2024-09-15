#!/bin/bash


ENCRYPTED_SCRIPT_URL="https://raw.githubusercontent.com/mikeesierrah/ez-backhaul/main/ez-backhaul.sh.enc"

echo "Downloading encrypted script..."
TEMP_ENCRYPTED_SCRIPT=$(mktemp)
curl -Ls "$ENCRYPTED_SCRIPT_URL" -o "$TEMP_ENCRYPTED_SCRIPT"


if [ ! -f "$TEMP_ENCRYPTED_SCRIPT" ]; then
    echo "Failed to download the encrypted script."
    exit 1
fi

echo -n "Enter decryption password: "
read -s PASSWORD
echo

echo "Decrypting and executing the script..."
openssl enc -aes-256-cbc -d -in "$TEMP_ENCRYPTED_SCRIPT" -pass pass:"$PASSWORD" | bash

if [ $? -ne 0 ]; then
    echo "Invalid password or decryption failed."
    rm "$TEMP_ENCRYPTED_SCRIPT"
    exit 1
fi

rm "$TEMP_ENCRYPTED_SCRIPT"
