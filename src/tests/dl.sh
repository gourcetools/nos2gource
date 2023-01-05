echo '["REQ", "RAND", {"kinds": [1], "limit": 100}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2].created_at' > time.json
echo "Done"

echo '["REQ", "RAND", {"kinds": [1], "limit": 100}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2].pubkey' > pubkey.json
echo "Done"
