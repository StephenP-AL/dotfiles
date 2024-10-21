#! /bin/bash
pushd .
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR
echo "Commit message:"
read M
for FILE in $(git ls-tree $(git rev-parse --abbrev-ref HEAD) --name-only | grep '^\.'); do
	cat ~/$(basename $FILE) > $FILE
done
git commit -am "$M"
git push
popd
