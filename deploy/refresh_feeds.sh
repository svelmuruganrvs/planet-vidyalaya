#!/usr/bin/env bash
CONFIG=config/config.ini

cd /var/www/planet_vidyalaya

cp $CONFIG $CONFIG.orig

deploy/prepare_config_for_multiple_pages.sh

# Get List of feeds
python deploy/fetch_feed_list_from_google_docs.py >> $CONFIG

# Run Planet
python /var/www/venus/planet.py $CONFIG

# Generate annotations file for Google CSE
wget -O google_cse_annotations.xml "http://www.google.com/cse/tools/makeannotations?url=blogs.rmv.ac.in%2Fopml.xml&label=_cse_-c04vdhk8jg"

deploy/cleanup.sh
