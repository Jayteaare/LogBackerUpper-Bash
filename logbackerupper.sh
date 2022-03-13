#!/bin/bash

if [ -d /var/backups/logbackerupper ]
then
        echo "We're just spinning up.."
        sleep 2
else
        echo "It's your first time! Let us take care of some admin stuff!"
        mkdir /var/backups/logbackerupper/
        mkdir /var/backups/logbackerupper/error/
        mkdir /var/backups/logbackerupper/logs/
        sleep 2
fi

exec 2>> //var/backups/logbackerupper/error/error.log

echo "Provide directory to be backed up:"
read USERDIR
echo "Processing..."
sleep 3

echo "MD5 hashes of files within $USERDIR" >> hashed_logs.txt
for file in $(find $USERDIR -type f)
do
        ls /var/log | grep .log* | cp $file "/var/backups/logbackerupper/logs/${file##*/}-$(date +"%m-%d-%y-%r")"
        ls /var/log | grep .log* | md5sum $file >> /var/backups/logbackerupper/hashed_logs.txt
done

echo "Process complete."
echo "Your files can be found in /var/backups/logbackerupper/"
