
paste time log > timelog
paste timelog file > timelogfile

sed -i 's/$/.event/' timelogfile

# remove tabulation #
sed -i 's/\t//g' timelogfile

cat timelogfile | sort -n > gource

gource --realtime gource
rm -f file
rm -f gourceb
rm -f log
rm -f pubkey
rm -f raw 
rm -f time
rm -f timelog
