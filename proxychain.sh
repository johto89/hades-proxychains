#!/bin/bash

file="proxychains.conf"

if [ -f "$file" ] ; then
    rm "$file"
fi

cp sampleproxychains.conf $file
python3 get_proxy.py 10
cat good_proxies_list.txt >> $file

if [ ! -f "/etc/bakproxychains.conf" ] ; then
    cp /etc/proxychains.conf /etc/bakproxychains.conf
else
    cp proxychains.conf /etc/proxychains.conf
fi


