echo '["REQ", "RAND", {"kinds": [1], "limit": 8}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2].content' > raw.json
echo "Done"

echo '["REQ", "RAND", {"kinds": [1], "limit": 8}]' |
  nostcat wss://relay.nostr.ch |
  jq '.[2].id' > id.json
echo "Done"

