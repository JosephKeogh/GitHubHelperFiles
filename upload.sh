#!/bin/bash

# get the user's name
echo "Please enter your name..."
read userName

# the current date, to be used in push/pull history
now=`date`

# message to user
echo Thank You $userName
echo

	# message to user
	echo "You have made changes to the files..."
	echo
	echo "Saving your changes to the Cloud..."
	echo
	
	# Update the push history to have the user's name and the current time
	echo >> push-history.txt
	echo "$now" >> push-history.txt
	echo "$userName" >> push-history.txt

	# push the user's changes and store info
	echo Ignore the error message below.
	git add . >> push-history.txt
	echo
	echo A message from GitHub...
	git commit -m "Automatically making commit for $userName" >> push-history.txt
	git push >> push-history.txt

	# message to user
	echo
	echo "Changes saved to the Cloud."
	echo
	
	# store the changes to the push history in the repository
	echo Ignore the error message below.
	git add . >> trash.txt
	echo
	git commit --quiet -m "updating push history" >> trash.txt
	git push --quiet >> trash.txt
	
rm trash.txt

echo Finished!
