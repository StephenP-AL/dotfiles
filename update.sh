#! /bin/bash
for FILE in $(find ~/dotfiles -type f -name ".*"); do
#	rm $FILE
	cp ~/$(basename $FILE) $FILE
done
now=`date '+%Y%m%d_%H%M%S'`
git commit -am "Automated backup of dotfiles on $now"
git push
