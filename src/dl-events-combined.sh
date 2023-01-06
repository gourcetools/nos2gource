LIMIT="10"
cd ../gourcelogs
rm -f *.*
cd ../src


while read RELAY
do
	RELAYSHORT=$(echo "$RELAY" | sed 's/^.\{6\}//')
	echo $RELAY
	echo $RELAYSHORT
echo "Downloading events timestamps"


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

# end of 01 dl 

echo "Removing quotes from pubkeys..."
sed -i 's/^.//' pubkey
sed -i 's/.$//' pubkey
echo "Removed quotes from pubkeys  		done"
echo "Removed quotes from pubkeys  	:)	done"
echo "Removed quotes from pubkeys  		done"
cp pubkey file

# end of 02 sed pubkey

echo " Adding |A to pubkeys..."
sed 's/$/|A|/' pubkey > log
echo " Added |A to pubkeys			done "

#end of add a

sed -i 's/$/|/' time
echo " Added | to time 						done"

# end of slash time

echo "Adding relay directory."
sed -i 's/$/ '$RELAYSHORT'/' log
sed -i 's/$/\//' log

echo "ok"

#end of add relay name


paste time log > timelog
paste timelog file > timelogfile

sed -i 's/$/.event/' timelogfile

# remove tabulation #
sed -i 's/\t//g' timelogfile

cat timelogfile | sort -n > $RELAYSHORT.txt
sed -i 's/ //g' $RELAYSHORT.txt


mv $RELAYSHORT.txt ../gourcelogs/$RELAYSHORT.txt

done < relay.txt

rm -f file
rm -f gourceb
rm -f log
rm -f pubkey
rm -f raw 
rm -f time
rm -f timelog
rm -f timelogfile

cd ../gourcelogs
cat *.txt | sort -n > combined.txt
echo ALL DONE
gource combined.txt
cd ../src
echo ALL DONE.

