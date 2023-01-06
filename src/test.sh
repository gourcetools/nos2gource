while read RELAY
do

	RELAYSHORT=$(echo "$RELAY" | sed 's/^.\{6\}//')


	echo $RELAY
	echo $RELAYSHORT
done < relay.txt
