#!/usr/bin/env python3

import sqlite3
import os
import errno
import argparse


def make_sure_path_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise


parser = argparse.ArgumentParser(description='')
parser.add_argument('-c', '--creator', nargs='+', help='Download only the videos by a specific creator', type=str, default="", action="store")
parser.add_argument('-t', '--testing', help='Enables the testing mode: not setting items as read after downloading', action="store_true")
args = parser.parse_args()

con = sqlite3.connect(f"{os.environ['HOME']}/.newsboat/cache.db")
cur = con.cursor()

make_sure_path_exists('./Youtube/')
creator = " ".join(args.creator)

for row in cur.execute(f'select url, author from rss_item WHERE "unread"=1 and author like "%{creator}%" collate nocase and "url" like "%youtube%";'):
    url, author = row
    folder = author.replace(" ", "_").lower()
    make_sure_path_exists(f'./Youtube/{folder}')
    os.system(f'youtube-dl --restrict-filenames -o "./Youtube/{folder}/%(title)s-%(id)s.%(ext)s" {url}')

if not args.testing:
    cur.execute(f'update rss_item set "unread" = 0 WHERE "unread"=1 and author like "%{creator}%" and "url" like "%youtube%";')
con.commit()
con.close()
