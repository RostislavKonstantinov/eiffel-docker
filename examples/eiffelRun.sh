#!/bin/bash

exec  1> $"/usercode/logfile.txt"
exec  2> $"/usercode/errors"

START=$(date +%s.%2N)

cd /usercode/

findargs=()
for i in "$@"; do
     findargs+=('!' '-name' "$i")
done
file_other_ecf=$(find -maxdepth 1 -name "*.ecf" "${findargs[@]}")
rm -rf $file_other_ecf

file=$(find -maxdepth 1 -name "junit-results.*" )
rm -rf $file


ec -clean -batch $@
#printf "T\nE\nQ" | ec $@  -loop >"logfile.txt" 2>&1
printf "T\nE\nQ" | ec $@  -loop  2>"logfile.txt"
cp logfile.txt  junit-results.txt

python3 parser_eiffel.py


END=$(date +%s.%2N)
runtime=$(echo "$END - $START" | bc)

echo "--------------------"
echo "*-COMPILEBOX::ENDOFOUTPUT-*" $runtime

cd ..
mv /usercode/logfile.txt /usercode/completed
