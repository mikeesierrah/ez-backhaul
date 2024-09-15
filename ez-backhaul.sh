#!/bin/bash

#!/bin/bash

URL="https://raw.githubusercontent.com/mikeesierrah/ez-backhaul/main/ez-backhaul.sh.enc"

echo "Downloading encrypted script..."
ENCRYPTED_SCRIPT=$(mktemp)
curl -Ls "$URL" -o "$ENCRYPTED_SCRIPT"

echo -n "Enter decryption password: "
read -s PASSWORD
echo

DECRYPTED_SCRIPT=$(mktemp)
openssl enc -aes-256-cbc -d -in "$ENCRYPTED_SCRIPT" -pass pass:"$PASSWORD" -out "$DECRYPTED_SCRIPT"
if [ $? -ne 0 ]; then
    echo "Failed to decrypt the script. Check your password or the file."
    rm "$ENCRYPTED_SCRIPT" "$DECRYPTED_SCRIPT"
    exit 1
fi

chmod +x "$DECRYPTED_SCRIPT"
echo "Running the decrypted script..."
bash "$DECRYPTED_SCRIPT"
if [ $? -ne 0 ]; then
    echo "Failed to execute the decrypted script."
    rm "$ENCRYPTED_SCRIPT" "$DECRYPTED_SCRIPT"
    exit 1
fi

rm "$ENCRYPTED_SCRIPT" "$DECRYPTED_SCRIPT"
