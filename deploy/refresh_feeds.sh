#!/usr/bin/env bash
CONFIG=config/config.ini

cd /var/www/blogs_planet

google docs get --title "Add your Blog" --format "csv" -u "help@rmv.ac.in"
mv "Add your Blog.csv" subscriptions.csv

cp $CONFIG $CONFIG.orig

for line in `tail -n+2 subscriptions.csv`
do
    feed=`echo $line | cut -d, -f4 `
    author=`echo $line | cut -d, -f2`
    register_number=`echo $line | cut -d, -f3`
    avatar=`echo $line | cut -d, -f5`
    accepted=`echo $line | cut -d, -f6`

    if [ "$accepted" == "Yes" ]
    then
      echo "[$feed]" >> $CONFIG
      echo "author = $author" >> $CONFIG
      echo "register_number = $register_number" >> $CONFIG
      echo "avatar = $avatar" >> $CONFIG
    fi
done

python /var/www/venus/planet.py $CONFIG

mv $CONFIG.orig $CONFIG
