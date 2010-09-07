#!/usr/bin/env bash
CONFIG=config/config.ini

cd /var/www/blogs_planet

google docs get --title "Add your Blog" --format "csv" -u "help@rmv.ac.in"
mv "Add your Blog.csv" subscriptions.csv
echo "" >> subscriptions.csv

cp $CONFIG $CONFIG.orig

while read line
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
done < subscriptions.csv

python /var/www/venus/planet.py $CONFIG

# Generate annotations file for Google CSE
wget -O google_cse_annotations.xml "http://www.google.com/cse/tools/makeannotations?url=blogs.rmv.ac.in%2Fopml.xml&label=_cse_-c04vdhk8jg"

mv $CONFIG.orig $CONFIG
