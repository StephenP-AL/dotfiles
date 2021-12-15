#! /bin/bash
echo "Commit message:"
read M
for FILE in $(find ~/dotfiles -type f -name ".*"); do
#	rm $FILE
	cat ~/$(basename $FILE) > $FILE
done
#now=`date '+%Y%m%d_%H%M%S'`
git commit -am "$M"
git push
