#!/usr/bin/env python

import os
from gdata.spreadsheet.text_db import DatabaseClient, Database, Table
import feedfinder

client = DatabaseClient(username=os.environ['GOOGLE_DOCS_USERNAME'],
                        password=os.environ['GOOGLE_DOCS_PASSWORD'])

# Fetch our spreadsheet with the name "Add your Blog"
db = client.GetDatabases(name='Add Your Blog')[0]

# Fetch the first worksheet in the spreadsheet
table = db.GetTables(worksheet_id='od6')[0]

# Get rows whose column "Accepted" is set to "Yes"
rows = table.FindRecords('accepted == Yes')

for row in rows:
    blog_url = row.content['yourblogurl']
    rss_url = row.content['blogrssfeed']
    author = row.content['name']
    register_number = row.content['registernumber']
    avatar_url = row.content['linktoyourphoto']

    if not rss_url:
        # Auto-discover Feed URL
        rss_url = feedfinder.feed(blog_url)
        row.content['blogrssfeed'] = rss_url
        # Update Google Spreadsheet so that we need not recompute next time.
        # See, using Google API is so simple. That's why I love Google.
        row.Push()

    if rss_url:
        print "[%s]" % rss_url
        print "author = %s" % author
        print "register_number = %s" % register_number
        print "avatar = %s" % (avatar_url or '')
