#!/bin/bash
#dl-events-combined.sh

# Set this variable to the maximum events you want to recieve from each relay
LIMIT="100"

echo " == Downloading messages initiated == "
echo " == We will ask each relay for $LIMIT events ==" 

while read RELAY
do
	RELAYSHORT=$(echo "$RELAY" | sed 's/^.\{6\}//')
	EXTENSION=$(echo ${RELAYSHORT##*.})
	echo "Downloading $LIMIT events	 from: $RELAYSHORT"
	echo "Downloading $LIMIT timestamps		from: $RELAYSHORT"
	echo '["REQ", "RAND", {"kinds": [2], "limit": '$LIMIT'}]' |
 	nostcat "$RELAY" |
  	jq '.[2].created_at' > ../tmp/time
	echo "Downloading $LIMIT pubkeys		from: $RELAYSHORT"
	echo '["REQ", "RAND", {"kinds": [2], "limit": '$LIMIT'}]' |
  	nostcat "$RELAY" |
  	jq '.[2].pubkey' > ../tmp/pubkey
	echo "Downloading $LIMIT events content		from: $RELAYSHORT"
	echo '["REQ", "RAND", {"kinds": [2], "limit": '$LIMIT'}]' |
 	nostcat "$RELAY" |
  	jq '.[2].content' > ../tmp/content
	# end of Download
	echo "Removing quotes from content."
	sed -i 's/^.//' ../tmp/content
	echo "Removing quotes from content.."
	echo "Removing quotes from content..."
	sed -i 's/.$//' ../tmp/content
	echo "Removed quotes from content... "
	echo "Removing quotes from pubkey"
	sed -i 's/^.//' ../tmp/pubkey
	sed -i 's/.$//' ../tmp/pubkey
	echo "Removed quotes from content... "
	# end of 02 sed pubkey
	echo "Adding |A to pubkeys."
	sed 's/$/|A|/' ../tmp/pubkey > ../tmp/log
	echo "Added |A to pubkeys..."
	#end of add A
	echo "Adding | to time.  "
	sed  's/$/|/' ../tmp/time > ../tmp/timesed
	echo "Added | to time"
	# end of slash time
	echo "Adding relay directory."
	sed -i 's/$/ '$RELAYSHORT'/' ../tmp/log
	sed -i 's/$/\//' ../tmp/log
	echo "Adding relay directory."
	#end of add relay name
	paste ../tmp/timesed ../tmp/log > ../tmp/timelog
	paste ../tmp/timelog ../tmp/content > ../tmp/timelogcontent
	sed -i 's/$/\//' ../tmp/timelogcontent
	paste ../tmp/timelogcontent ../tmp/time > ../tmp/timelogcontenttime
	
	echo "Adding EXTENSION directory."
	sed -i 's/$/ '.$EXTENSION'/' ../tmp/timelogcontenttime
	echo "Adding relay directory."

	# remove tabulation #
	sed -i 's/\t//g' ../tmp/timelogcontenttime
	cat ../tmp/timelogcontenttime | sort -n > ../tmp/$RELAYSHORT.txt
	sed -i 's/ //g' ../tmp/$RELAYSHORT.txt
	mv ../tmp/$RELAYSHORT.txt ../gourcelogs/$RELAYSHORT.txt
	echo "Done with $RELAYSHORT"
	echo "Next"
done < ../relays.txt
# Removing logs that failed for sure #
cd ../gourcelogs
find . -type f -name "*.txt" -size -69c -delete


# THIS IS DONE AS A SAFETY MEASURE BECAUSE SOMETIMES RELAYS OUTPUT SHIT
# 							THAT BREAK THIS SCRIPT . DONT REMOVE 
#
# Deletes files that echoed something normal and keep the ones that echoed errors. 
# If everything is fine the echo return for a gource is 68bytes so we remove anything  
# bigger than 68bytes and all we have left is the faulty logs with $RELAYNAME.txt
# We will delete later, before combining all logs.
#for for each log inside logs folder, start a gource.
#
	# we start in the future, by doing that, we dont have to wait for the final output.
	# gource will try to read the log, then if its working it will start in 2200 wich is
	# far away from now in human time and will exit properly because no commits.
	# if it fail to read the log, it wont start and output the error.
	# Until we find a way to run gource in the background,
	# this step will keep  opening gource windows in a annoying manner each time its testing a log.
	
for file in *
	do
	gource --start-date "2200-01-01 12:00" "$file" 2> ../logs/$file
	echo " === Testing $file === "
done

cd ../logs
find . -type f -name "*.txt" -size -69c -delete

# Because the name of the failed log output file correspond to the name of the log file
# we delete each file in log that exist also in logfiles, doing this we only have 
# working gource logs left in the gourcelogs folder. then we can combine them

for file in *
do
	cd ../gourcelogs
	rm -f "$file"
	echo " ====================== "
	echo " === Deleted "$file" == "
	echo " === Something went wrong with this log === "
	cd ../logs
done

# THIS IS DONE AS A SAFETY MEASURE BECAUSE SOMETIMES RELAYS OUTPUT SHIT
# 							THAT BREAK THIS SCRIPT . DONT REMOVE 



cd ../gourcelogs
cat *.txt | sort -u > ../combined-recommand
sed -i 's/ //g' ../combined-recommand
sed -i 's/\t//g' ../combined-recommand

echo "ALL DONE LETS START GOURCE."

## Create CURRENTDATE & GOURCESTARTDATE variable ##
CURRENTDATE=`date +"%Y-%m-%d"`
GOURCESTARTDATE=`date -d '-365day' +"%Y-%m-%d"`
rm -f ../logs/*
rm -f ../gourcelogs/*
rm -f ../tmp/*
gource \
    ../combined-recommand \
    --seconds-per-day "5" \
    --padding 1.30 \
    --bloom-intensity 0.01 \
    --camera-mode overview \
    --user-font-size "1" \
    --dir-name-position "1" \
		--dir-font-size "40" \
    --dir-name-depth 1 \
    --hide "users,usernames,filenames,root,tree" 
