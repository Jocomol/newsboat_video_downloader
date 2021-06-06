#!/usr/bin/env python3

import sqlite3
import os
import errno


def make_sure_path_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise


con = sqlite3.connect(os.environ['HOME'] + '/.newsboat/cache.db')
cur = con.cursor()

make_sure_path_exists('./Youtube/')

for row in cur.execute('select url, author from rss_item WHERE "unread"=1 and "url" like "%youtube%";'):
    url = row[0]
    author = row[1]
    folder = author.replace(" ", "_").lower()
    make_sure_path_exists('./Youtube/' + folder)
    os.system("youtube-dl -o ./Youtube/" + folder + " " + url)

cur.execute('update rss_item set "unread" = 0 WHERE "unread"=1 and "url" like "%youtube%";')

con.close()
