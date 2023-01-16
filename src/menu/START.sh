#!/bin/bash
# START.sh
echo "";

echo "            ┌┐┌┌─┐┌─┐   ┌─┐┌─┐┬ ┬┬─┐┌─┐┌─┐  ";
echo "            ││││ │└─┐ 2 │ ┬│ ││ │├┬┘│  ├┤   ";
echo "            ┘└┘└─┘└─┘   └─┘└─┘└─┘┴└─└─┘└─┘  ";
echo "  "
echo "     ┌─────────────┐";
echo "     │  MAIN MENU  │";
echo "   ┌─┴─────────────┴──────────────────────────┐";
echo "   │    1) todo                               │";
echo "   ├──────────────────────────────────────────┤";
echo "   │    4) todo                               │";
echo "   ├──────────────────────────────────────────┤";
echo "   │    5) Reset nos2gource   	              │";
echo "   │    6) Exit                               │";
echo "   └──────────────────────────────────────────┘";
echo -n "    └─> Enter your choice [1-6]:";

# Running a forever loop using while statement
# This loop will run untill select the exit option.
# User will be asked to select option again and again
while :
do

# reading choice
read choice

# case statement is used to compare one value with the multiple cases.
case $choice in
  # Pattern 1
  1)  echo "== todo ==" 
    cd ../keygen
   ./keygen.sh
   ./name.sh
  source ../menu/START.sh ;;
  2)  echo "== todo =="
  cd ../make-json-nip05
   ./makejson.sh
  source ../menu/START.sh ;;
  # Pattern 3
  3)  echo "== todo =="
  cd ../sendtext
  ./send-loop.sh 
  source ../menu/START.sh ;;
    # Pattern 4
  4)  echo "== todo =="
  cd ../follow
   ./follow.sh 
  source ../menu/START.sh ;;
  # Pattern 5
  5)  echo "== todo =="
  cd ../reset
   ./reset.sh 
  source ../menu/START.sh ;;
  # Pattern 6
  5)  echo "Exit"
      exit;;

  # Default Pattern
  *) echo "     Invalid number..."
    echo "     └─> Enter your choice [1-6]:";;
esac
  echo
done
