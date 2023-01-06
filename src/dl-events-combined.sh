LIMIT="10"
cd ../gourcelogs
rm -f *.*
cd ../src


while read RELAY
do
	RELAYSHORT=$(echo "$RELAY" | sed 's/^.\{6\}//')
	echo "Downloading $LIMIT events	 from: $RELAYSHORT"
	clear
echo "Downloading $LIMIT timestamps 	from: $RELAYSHORT"
echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
  nostcat "$RELAY" |
  jq '.[2].created_at' > time
clear
echo "Downloading $LIMIT pubkeys 	from: $RELAYSHORT"
echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
  nostcat "$RELAY" |
  jq '.[2].pubkey' > pubkey
clear
# end of 01 dl 
echo "Removing quotes from pubkeys."
sed -i 's/^.//' pubkey
echo "Removing quotes from pubkeys.."
echo "Removing quotes from pubkeys..."
sed -i 's/.$//' pubkey
echo "Removed quotes from pubkeys...  							---->	done"
clear
cp pubkey file
# end of 02 sed pubkey
echo "Adding |A to pubkeys."
sed 's/$/|A|/' pubkey > log
echo "Added |A to pubkeys...									---->	done"
clear
#end of add a
echo "Adding | to time.  "
sed -i 's/$/|/' time
echo "Added | to time											---->	done"
clear
# end of slash time
echo "Adding relay directory."
sed -i 's/$/ '$RELAYSHORT'/' log
sed -i 's/$/\//' log
echo "Adding relay directory. 							---->	done"
clear
#end of add relay name
paste time log > timelog
paste timelog file > timelogfile
sed -i 's/$/.event/' timelogfile
# remove tabulation #
sed -i 's/\t//g' timelogfile
cat timelogfile | sort -n > $RELAYSHORT.txt
sed -i 's/ //g' $RELAYSHORT.txt
mv $RELAYSHORT.txt ../gourcelogs/$RELAYSHORT.txt
echo "Done with $RELAYSHORT"
clear
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
for file in *
do
	gource --start-date "2040-01-01 12:00" $file 2> ../logs/$file
	echo " === Testing $file === "
done
cd ../logs
find . -type f -name "*.txt" -size -69c -delete
for file in *
do
	cd ../gourcelogs
	rm -f "$file"
	echo " === Purged "$file" . Something went wrong so we removed this log. === "
	cd ../logs
done



cd ../gourcelogs
cat *.txt | sort -u > combined.txt

echo "ALL DONE LETS START GOURCE."
gource combined.txt 
cd ../src
echo "ALL DONE."

