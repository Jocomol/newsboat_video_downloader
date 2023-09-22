#!/bin/bash

d_flag='false'
m_flag='false'
AUTHOR=''

print_usage() {
    echo "usage: newsboat_video_downloader [-h] [-a AUTHOR] [-m]"
    echo ""
    echo "optional arguments:"
    echo "-h,                      show this help message and exit"
    echo "-a, AUTHOR               Download only the videos by a specific creator"
    echo "-m,                      Enables the marking mode which will mark the videos as watched in newsboat"
    echo "-d,                      Enables the detox mode and will execute detox in the video directory after downloading"
    exit 1
}

while getopts 'mda:h' flag; do
  case "${flag}" in
    m) m_flag='true' ;;
    d) d_flag='true' ;;
    a) AUTHOR="${OPTARG}" ;;
    h) print_usage ;;
  esac
done


# Change those to reflect your setup
DATABASELOC="$XDG_DATA_HOME/newsboat/cache.db"
WEBSITEURLLIST="$XDG_CONFIG_HOME/newsboat/websitelist"
VIDEOFOLDER="$HOME/Videos"

# Don't change them
URLPREFIX="url like"
QUERY="select url from rss_item where unread=1 and ("
UPDATEQUERY="update rss_item set unread=0 WHERE unread=1 and ("
AUTHOR_QUERY_SUFFIX="and author = '$AUTHOR'"
rendering_query=""

# Program
while read url; do
    rendering_query="$rendering_query $URLPREFIX '$url%' or"
done <$WEBSITEURLLIST

rendering_query="${rendering_query::-2})"

# If Autor specified
if ! [ -z "$AUTHOR" ];
then
    rendering_query="$rendering_query $AUTHOR_QUERY_SUFFIX"
fi

rendering_query="$rendering_query;"

QUERY="$QUERY $rendering_query"

sqlite3 $DATABASELOC "$QUERY" > /tmp/videolist

yt-dlp --format mp4 --embed-thumbnail -o "$VIDEOFOLDER/%(uploader)s/%(title)s.%(ext)s" -a /tmp/videolist

# Update
if $m_flag; then
    UPDATEQUERY="$UPDATEQUERY $rendering_query"
    sqlite3 $DATABASELOC "$UPDATEQUERY"
    newsboat -x reload
fi

if $d_flag; then
    detox -r $VIDEOFOLDER/*
fi

exit 0
