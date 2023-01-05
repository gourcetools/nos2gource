echo '["REQ", "RAND", {"kinds": [1], "limit": 10}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2]' > raw
echo "Done"

echo '["REQ", "RAND", {"kinds": [1], "limit": 10}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2].created_at' > time
echo "Done"

echo '["REQ", "RAND", {"kinds": [1], "limit": 10}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2].pubkey' > pubkey
echo "Done"
