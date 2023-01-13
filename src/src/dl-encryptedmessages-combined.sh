#!/bin/bash
#dl-encryptedmessages-combined.sh

# ================================== CONFIG START

KIND="4"
# Set this variable to the kind of  events you want to recieve from each relay
LIMIT="1000"
# Set this variable to the maximum events you want to recieve from each relay
TYPE="private-messages"
# Set this variable to the name of this folder inside gource relay
OUTPUT="combined-private-messages"
# Set this variable to the desired gource output file name
# ================================== CONFIG END

rm -f ../logs/*
rm -f ../gourcelogs/*
rm -f ../tmp/*

echo " == Downloading messages initiated"
echo " == We will ask each relay for $LIMIT events" 


while read RELAY
do
	RELAYSHORT=$(echo "$RELAY" | sed 's/^.\{6\}//')
	EXTENSION=$(echo ${RELAYSHORT##*.})
	echo " == Downloading $LIMIT timestamps		from: $RELAYSHORT"
	echo '["REQ","RAND", {"kinds": ['$KIND'],"limit": '$LIMIT'}]' |
 	nostcat --connect-timeout 250 "$RELAY" |
  	jq '.[2].created_at' > ../tmp/date
echo " == Done downloading. =="
	
	echo " == Downloading $LIMIT pubkeys		from: $RELAYSHORT"
	echo '["REQ","RAND", {"kinds": ['$KIND'],"limit": '$LIMIT'}]' |
  	nostcat --connect-timeout 250 "$RELAY" |
  	jq '.[2].pubkey' > ../tmp/pubkey
		echo " == Done downloading. =="

	echo " == Downloading $LIMIT events		from: $RELAYSHORT"
	echo '["REQ","RAND", {"kinds": ['$KIND'],"limit": '$LIMIT'}]' |
 	nostcat --connect-timeout 250 "$RELAY" |
  	jq '.[2].id' > ../tmp/id
echo " == Done downloading. =="	
	# end of Download
	

	echo " == Removing quotes from id. =="
	sed -i 's/^.//' ../tmp/id
	sed -i 's/.$//' ../tmp/id
	echo " == Removing quotes from pubkey. =="
	sed -i 's/^.//' ../tmp/pubkey
	sed -i 's/.$//' ../tmp/pubkey
	# end of 02 sed pubkey
	echo " == Adding |A to pubkeys. =="
	sed 's/$/|A|/' ../tmp/pubkey > ../tmp/log
	#end of add A
	echo " == Adding  to date. "
	sed  's/$/|/' ../tmp/date > ../tmp/datesed
	# end of slash date
	# == Adding relay director
	sed -i 's/$/ '$RELAYSHORT'/' ../tmp/log				 
	sed -i 's/$/\//' ../tmp/log										
	
	sed -i 's/$/ '$TYPE'/' ../tmp/log				 
	sed -i 's/$/\//' ../tmp/log				
	
	
	
	#end of add relay name
	paste ../tmp/datesed ../tmp/log > ../tmp/datelog
	paste ../tmp/datelog ../tmp/id > ../tmp/datelogid
	sed -i 's/$/\//' ../tmp/datelogid
	paste ../tmp/datelogid ../tmp/date > ../tmp/datelogiddate
	
	echo "Adding EXTENSION directory."
	sed -i 's/$/ '.$EXTENSION'/' ../tmp/datelogiddate
	echo "Adding relay directory."

	# remove tabulation #
	sed -i 's/\t//g' ../tmp/datelogiddate
	cat ../tmp/datelogiddate | sort -n > ../tmp/$RELAYSHORT.txt
	sed -i 's/ //g' ../tmp/$RELAYSHORT.txt
	mv ../tmp/$RELAYSHORT.txt ../gourcelogs/$RELAYSHORT.txt
	echo "Done with $RELAYSHORT"
	echo "Next"
	
done < ../relays.txt


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

cd ../gourcelogs
for file in *
	do
	gource --start-date "2200-01-01 12:00" "$file" 2> ../logs/$file
	echo " == Testing $file"
done

cd ../logs
find . -type f -name "*.txt" -size -100c -delete

# Because the name of the failed log output file correspond to the name of the log file
# we delete each file in log that exist also in logfiles, doing this we only have 
# working gource logs left in the gourcelogs folder. then we can combine them

for file in *
do
	cd ../gourcelogs
	rm -f "$file"
	echo " == =============="
	echo " == Deleted "$file" =="
	echo " == Something went wrong with this log. =="
	cd ../logs
done

# THIS IS DONE AS A SAFETY MEASURE BECAUSE SOMETIMES RELAYS OUTPUT SHIT
# 							THAT BREAK THIS SCRIPT . DONT REMOVE 



cd ../gourcelogs
cat *.txt | sort -u > ../$OUTPUT
sed -i 's/ //g' ../$OUTPUT
sed -i 's/\t//g' ../$OUTPUT

cd ..
cat $OUTPUT | awk '!seen[substr($0,1,74)]++' > $OUTPUT.2
rm -f $OUTPUT
cp $OUTPUT.2 $OUTPUT
rm -f $OUTPUT.2
cd src