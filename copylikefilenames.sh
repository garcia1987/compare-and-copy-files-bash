#!/bin/bash

#This script takes two directories input by the user
#Compares file names without the extension (i.e. game.sfc / game.png)
#Then takes the matching (duplicate) file names and drops them into
#A uniquelist.txt file and parses that file line by line moving the file from
#The first directory entered into the second directory entered.


echo "Starting Script"

#Get directories from user
#Read in first directory
read  -p "Enter directory to move files FROM: " dir1
#Read in second directory
read  -p "Enter directory to move files TO: " dir2

#Parse directories for file names and add to list.txt
#The command sed 's/....$//' removes the file extension (last 4 characters in file name)
echo "Parsing $dir1"
ls -1 $dir1 | sed 's/....$//' >> list.txt
echo "Parsing $dir2"
ls -1 $dir2 | sed 's/....$//' >> list.txt

#Read the generated list and find the duplicate names, output ONLY the duplicate names to the uniquelist.txt file
sort list.txt | uniq -d | less >> uniquelist.txt

#Move to dir1
cd $dir1

#Read the sorted list and move the appropriate files from dir1 to dir2
file="/home/morgan/uniquelist.txt"
while read line;
	do
	echo "Moving ${line} from $dir1 to $dir2"
	mv "${line}.png" "$dir2${line}.png"
	sleep .02
	done < "${file}"

#move back home
cd /home/morgan/
#Cleanup
rm list.txt uniquelist.txt
