#!/usr/bin/env bash
#set -x

CONFIG=config/config.ini

cd /var/www/planet_vidyalaya

# Purge existing files
rm page?.html
rm page??.html

number_of_pages=( `grep number_of_pages $CONFIG | cut -d"=" -f2` ) #eg: 10
# items_per_page is a misnomer. That's how Planet calls it.
number_of_items=( `grep items_per_page $CONFIG | cut -d"=" -f2` ) #eg: 200

items_per_page=$(( number_of_items/number_of_pages )) #eg: 20

page_num=1

while [ $page_num -le $number_of_pages ]
do
    page_name=page${page_num}.html.dj

    begin_item=$(( 1 + (page_num - 1) * items_per_page))
    end_item=$(( begin_item + items_per_page - 1))

    cp config/page_template.html.dj config/$page_name

    sed -i s/begin_item_placeholder/$begin_item/g config/$page_name
    sed -i s/end_item_placeholder/$end_item/g config/$page_name
    sed -i s/num_of_pages_placeholder/$number_of_pages/g config/$page_name
    sed -i s/page_num_placeholder/$page_num/g config/$page_name

    sed -i s/"template_files =  "/"template_files =  $page_name "/ $CONFIG

    (( page_num++ ))
done
