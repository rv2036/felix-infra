#!/bin/bash
set -e

echo "Parsing userMap.json"
users="$(jq -r .userMap[][] userMap.json)"

echo "Checking userMap ordering"
if ! jq -e '.userMap | keys_unsorted == keys' userMap.json >/dev/null; then
    echo "userMap entries are not in alphabetical order."
    exit 1
fi

for user in ${users[@]}; do
    echo "Fetching keys for $user..."
    keys=$(curl -fsS https://github.com/$user.keys)

    echo "Checking if $user has SSH keys added..."
    if [[ -z "${keys[@]}" ]]; then
        echo "No SSH key found for $user."
        exit 1
    fi
done
