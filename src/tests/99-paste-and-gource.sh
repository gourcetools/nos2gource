
paste time log > timelog
paste timelog file > gource

sed -i 's/$/.event/' gource
# remove tabulation #
sed -i 's/\t//g' gource
gource gource
rm -f file
rm -f gourceb
rm -f log
rm -f pubkey
rm -f raw 
rm -f time
rm -f timelog
