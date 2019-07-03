#!/bin/sh
#AccuWeather (r) RSS weather for conky
METRIC=1 #0 for F, 1 for C

if [ -z "$1" ]; then
    set -- "EUR|DE|GM017|ILMENAU"
elif [ "$1" = "-h" ]; then
    echo "USAGE: $0 <locationcode>"
    echo "Example: EUR|DE|GM017|BERLIN"
fi

URL="http://rss.accuweather.com/rss/liveweather_rss.asp?metric=${METRIC}&locCode=$1"
curl -s "$URL" | perl -ne 'if (/Currently/) {chomp;/\<title\>Currently: (.*)?\<\/title\>/; print "$1"; }'
