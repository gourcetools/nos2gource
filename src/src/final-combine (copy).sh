
rm -f ../logs/*
rm -f ../gourcelogs/*
rm -f ../tmp/*

cd ..
cat combined* | sort -u > ./final.txt

gource \
    combined-private-messages \
    --seconds-per-day "5" \
    --padding 1.30 \
    --bloom-intensity 0.01 \
    --camera-mode overview \
    --user-font-size "1" \
    --dir-name-position "1" \
	--dir-font-size "20" \
    --dir-name-depth 2 \
    --hide "users,usernames,filenames,root,tree" 


rm -f combined*