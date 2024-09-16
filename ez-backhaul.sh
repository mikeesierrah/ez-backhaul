#!/bin/bash
set +o history

URL="https://raw.githubusercontent.com/mikeesierrah/ez-backhaul/main/ez-backhaul.sh.enc"

echo "Downloading encrypted script..."
encrypted_file=$(mktemp)
curl -Ls "$URL" -o "$encrypted_file"

echo -n "Enter decryption password: "
read -s password
echo

decrypted_content=$(openssl enc -aes-256-cbc -d -in "$encrypted_file" -pass pass:"$password")
if [ $? -ne 0 ]; then
    echo "Failed to decrypt the script. Check your password or the file."
    rm "$encrypted_file"
    exit 1
fi

bash -c "$decrypted_content"
if [ $? -ne 0 ]; then
    echo "Failed to execute the decrypted script."
    rm "$encrypted_file"
    exit 1
fi

rm "$encrypted_file"

unset password decrypted_content

set -o history