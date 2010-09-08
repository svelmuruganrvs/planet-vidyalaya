#!/usr/bin/env bash
CONFIG=config/config.ini

cd /var/www/blogs_planet

mv $CONFIG.orig $CONFIG

# Replace links to page1.html with /
sed -i s/page1.html//g page*html
cp page1.html index.html

# Add modification time to css so that browser can request fresh copy in case of changes
mtime=`ls -lc --time-style=+%Y%m%d%H%M%S media/css/index.css | cut -d" " -f6`
sed -i s/index.css/index.css?mtime=$mtime/g *.html

rm config/page?.html.dj
rm config/page??.html.dj





