#!/bin/bash

# get the user's name
echo "Please enter your name..."
read userName

# the current date, to be used in push/pull history
now=`date`

# message to user
echo Thank You $userName
echo

# get the status of the repository
git status > test.txt

# check if there where changes to any files by comparing status to no changes
diff test.txt download-ready.txt > difference.txt

# if there are changes
if [ -s difference.txt ]
then
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
	echo A message from GitHub...
	git add . >> push-history.txt
	git commit -m "Automatically making commit for $userName" >> push-history.txt
	git push >> push-history.txt

	# message to user
	echo
	echo "Changes saved to the Cloud."
	echo
	echo "Downloading files from the Cloud..."
	echo

	# now that the user's changes have been saved pull from the repository and store history
	echo >> pull-history.txt
	echo "$now" >> pull-history.txt
	echo $userName > pull-history.txt
	git pull >> pull-history.txt

	# store the changes to the pull and push history in the repository
	echo Ignore the error message below.
	git add . >> trash.txt
	echo
	git commit --quiet -m "updating pull and push history" >> trash.txt
	git push --quiet >> trash.txt

	# message to user
	echo "All files up to date with the Cloud."
	echo

# if there were no changes to the repository
else
	# message to user
	echo "You have made no changes to the files."
	echo 
	echo "Downloading files from the cloud..."
	echo

	# put the user's name and time in the pull history
	echo >> pull-history.txt
	echo $now >> pull-history.txt
	echo $userName >> pull-history.txt
	git pull >> pull-history.txt

	# store the pull history changes in the repository
	echo Ignore the error message below.
	git add . >> trash.txt
	echo
	git commit --quiet -m "updating pull history" >> trash.txt
	git push --quiet >> trash.txt

	# message to user
	echo "All files up to date with the Cloud."
	echo
fi


rm difference.txt
rm test.txt
rm trash.txt

echo Finished!
