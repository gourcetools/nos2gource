#!/bin/bash
#dl-events-combined.sh

LIMIT="1000"

echo " == Downloading messages initiated == "
echo " == We will ask each relay for $LIMIT events ==" 
echo " == Purging (potentially) old files =="

rm 	-f	../logs/*.*
rm	-f	../gourcelogs/*.*

while read RELAY
do
	RELAYSHORT=$(echo "$RELAY" | sed 's/^.\{6\}//')
	EXTENSION=$(echo ${RELAYSHORT##*.})
	echo "Downloading $LIMIT events	 from: $RELAYSHORT"
	echo "Downloading $LIMIT timestamps 	from: $RELAYSHORT"
	echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
 	nostcat "$RELAY" |
  	jq '.[2].created_at' > time
	echo "Downloading $LIMIT pubkeys 	from: $RELAYSHORT"
	echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
  	nostcat "$RELAY" |
  	jq '.[2].pubkey' > pubkey
	echo "Downloading $LIMIT events id from: $RELAYSHORT"
	echo '["REQ", "RAND", {"kinds": [1], "limit": '$LIMIT'}]' |
 	nostcat "$RELAY" |
  	jq '.[2].id' > id
	# end of 01 dl 
	echo "Removing quotes from id."
	sed -i 's/^.//' id
	echo "Removing quotes from id.."
	echo "Removing quotes from id..."
	sed -i 's/.$//' id
	echo "Removed quotes from id... "
	echo "Removing quotes from pubkey"
	sed -i 's/^.//' pubkey
	sed -i 's/.$//' pubkey
	echo "Removed quotes from id... "
	# end of 02 sed pubkey
	echo "Adding |A to pubkeys."
	sed 's/$/|A|/' pubkey > log
	echo "Added |A to pubkeys..."
	#end of add a
	echo "Adding | to time.  "
	sed  's/$/|/' time > timesed
	echo "Added | to time"
	# end of slash time
	echo "Adding relay directory."
	sed -i 's/$/ '$RELAYSHORT'/' log
	sed -i 's/$/\//' log
	echo "Adding relay directory."
	#end of add relay name
	paste timesed log > timelog
	paste timelog id > timelogid
	sed -i 's/$/\//' timelogid
	paste timelogid time > timelogidtime
	
	echo "Adding EXTENSION directory."
	sed -i 's/$/ '.$EXTENSION'/' timelogidtime
	echo "Adding relay directory."

	# remove tabulation #
	sed -i 's/\t//g' timelogidtime
	cat timelogidtime | sort -n > $RELAYSHORT.txt
	sed -i 's/ //g' $RELAYSHORT.txt
	mv $RELAYSHORT.txt ../gourcelogs/$RELAYSHORT.txt
	clear
	echo "Done with $RELAYSHORT"
	echo "Next"
done < relay.txt




cd ../gourcelogs


# Deletes files that echoed something normal and keep the ones that echoed errors. 
# If everything is fine the echo return for a gource is 68bytes so we remove anything  
# bigger than 68bytes and all we have left is the faulty logs with $RELAYNAME.txt
# We will delete later, before combining all logs.

#for for each log inside logs folder, start a gource
for file in *
do
	# we start in the future, by doing that, we dont have to wait for the final output.
	# gource will try to read the log, then if its working it will start in 2200 wich is
	# far away from now in human time and will exit properly because no commits.
	# if it fail to read the log, it wont start and output the error.
	# Until we find a way to run gource in the background,
	# this step will keep  opening gource windows in a annoying manner each time its testing a log.
	gource --start-date "2200-01-01 12:00" $file 2> ../logs/$file
	echo " === Testing $file === "
done
cd ../logs
find . -type f -name "*.txt" -size -69c -delete

for file in *
do
	cd ../gourcelogs
	rm -f "$file"
	echo " === Deleted "$file" == "
	echo " === Something went wrong with this log === "
	cd ../logs
done

cd ../src
rm -f file
rm -f log
rm -f pubkey
rm -f time
rm -f timelog
rm -f timelogfile

cd ../gourcelogs
cat *.txt | sort -u > combined_events
sed -i 's/ //g' combined_events
sed -i 's/\t//g' combined_events

echo "ALL DONE LETS START GOURCE."

## Create CURRENTDATE & GOURCESTARTDATE variable ##
CURRENTDATE=`date +"%Y-%m-%d"`
GOURCESTARTDATE=`date -d '-365day' +"%Y-%m-%d"`

gource \
    combined_events \
    --seconds-per-day "5" \
    --padding 1.30 \
    --bloom-intensity 0.01 \
    --camera-mode overview \
    --user-font-size "1" \
    --dir-name-position "1" \
		--dir-font-size "40" \
    --dir-name-depth 1 \
    --hide "users,usernames,filenames,root,tree" 

cd ../src
rm -f file
rm -f log
rm -f pubkey
rm -f time
rm -f timelog
rm -f timelogfile

echo "ALL DONE."
