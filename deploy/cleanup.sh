#!/usr/bin/env bash
CONFIG=config/config.ini

cd /var/www/blogs_planet

mv $CONFIG.orig $CONFIG

# Replace links to page1.html with /
sed -i s/page1.html//g page*html
cp page1.html index.html

rm config/page?.html.dj
rm config/page??.html.dj





