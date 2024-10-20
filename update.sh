#! /bin/bash
pushd .
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR
echo "Commit message:"
read M
for FILE in $(find $SCRIPT_DIR -type f -name ".*" ); do
	cat ~/$(basename $FILE) > $FILE
done
git commit -am "$M"
git push
popd
