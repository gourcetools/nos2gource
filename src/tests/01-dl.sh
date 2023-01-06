#
#echo "Downloading raw events..."
#echo '["REQ", "RAND", {"kinds": [1], "limit": 000}]' |
#  nostcat wss://relay.nostr.ch |
#  jq '.[2]' > raw
#echo "Downloading raw events				done"
#echo "Downloading raw events		:)		done"
#echo "Downloading raw events				done"
#

RELAY="wss://public.nostr.swissrouting.com"
LIMIT="1000"

echo "Downloading events timestamps from '$RELAY'..."
echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
  nostcat "$RELAY" |
  jq '.[2].created_at' > time
echo "Downloading events timestamps			done"
echo "Downloading events timestamps	:)		done"
echo "Downloading events timestamps			done"

echo "Downloading events pubkeys..."
echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
  nostcat "$RELAY" |
  jq '.[2].pubkey' > pubkey
echo "Downloading events pubkeys				done"
echo "Downloading events pubkeys		:)		done"
echo "Downloading events pubkeys				done"

