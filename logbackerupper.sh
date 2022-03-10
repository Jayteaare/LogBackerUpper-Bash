#!/bin/bash

mkdir /var/backups/logbackerupper/
mkdir /var/backups/logbackerupper/logs/
mkdir /var/backups/logbackerupper/error/

exec 2>> //var/backups/logbackerupper/error/error.log

echo "Provide directory to be backed up:"
read USERDIR
echo "Processing..."
sleep 3

echo "MD5 hashes of files within $USERDIR" >> hashed_logs.txt
for file in $(find $USERDIR -type f)
do
        cp "$file" "/var/backups/logbackerupper/logs/${file##*/}-$(date +"%m-%d-%y-%r")"
        md5sum $file >> /var/backups/logbackerupper/hashed_logs.txt
done

echo "Process complete."
echo "Your files can be found in /var/backups/logbackerupper/"
