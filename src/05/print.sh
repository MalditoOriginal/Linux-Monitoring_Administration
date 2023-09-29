#!/bin/bash

echo "Total number of folders = $(sudo find "$1" -mindepth 1 -type d | wc -l)"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
sudo du -hS "$1" | sort -rh | awk '{print NR" - "$2", "$1"B"}' | head -5 | column -t
echo "Total number of files = $(sudo find "$1" -mindepth 1 -type f | wc -l)"
echo "Number of:"
echo "Configuration files = $(sudo find $1 -type f | grep "\.conf" -c)"
echo "Text files = $(sudo find $1 -type f | grep "\.txt" -c)"
echo "Executable files = $(sudo find $1 -type f -executable | wc -l)"
echo "Log files = $(sudo find $1 -type f | grep "\.log" -c)"
echo "Archive files = $(sudo find $1 -name "*.rar" -o -name "*.zip" -o -name "*.tar"  -o -name "*.7z" -o -name "*.jar" | wc -l)"
echo "Symbolic links = $(sudo find $1 -type l | wc -l)"
echo "TOP 10 files of maximum size arranged in descending order:"
sudo sudo find $1 -type f -exec du -hS {} + | sort -hr | awk -F . '{if (NF>1) {print $0, $NF} else {print $0}}' | awk '{print NR" - "$2", "$1"B, "$3}' | head -10 | column -t
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file): "
file=`sudo find "$1" -type f -executable -exec du -hS {} + | sort -rh | head -10`
num=`sudo find "$1" -type f -executable -exec du -hS {} + | sort -rh | head -10 | wc -l`
i=1
while [ $i != $(( $num + 1 )) ]
do       
    file_name=`printf "$file" | awk '{print $2}' | awk "NR==$i"`
    md5=`md5sum $file_name | awk '{print $1}'`
    printf "$(printf "$file" | awk '{print NR" - "$2", "$1"B"}'W | awk "NR==$i"), $md5\n"
    i=$(( $i + 1 ))
done