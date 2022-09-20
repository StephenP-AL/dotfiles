#! /bin/bash
cd ~/dotfiles
echo "Commit message:"
read M
for FILE in $(find ~/dotfiles -type f -name ".*"); do
	cat ~/$(basename $FILE) > $FILE
done
git commit -am "$M"
git push
