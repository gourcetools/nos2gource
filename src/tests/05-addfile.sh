echo "Adding relay directory."
relay=`cat relay`
sed -i 's/$/\/events\//' log
echo $relay 
