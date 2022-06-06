#!/bin/bash
set -e

echo "Parsing gitakc.json"
users="$(jq -r .userMap[][] userMap.json)"

for user in ${users[@]}; do
    echo "Fetching keys for $user..."
    keys=$(curl -fsS https://github.com/$user.keys)

    echo "Checking if $user has SSH keys added..."
    if [[ -z "${keys[@]}" ]]; then
        echo "No SSH key found for $user."
        exit 1
    fi
done

echo "Parsing caat.json"
users="$(jq -r .userMap[][] caat.json)"

for user in ${users[@]}; do
    echo "Fetching keys for $user..."
    keys=$(curl -fsS https://github.com/$user.keys)

    echo "Checking if $user has SSH keys added..."
    if [[ -z "${keys[@]}" ]]; then
        echo "No SSH key found for $user."
        exit 1
    fi
done
