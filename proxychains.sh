#!/bin/bash

file="proxychains.conf"

if [ -f "$file" ] ; then
    rm "$file"
fi

cp sampleproxychains.conf $file


read -p "You want to update proxy list(y/N): " ans

if [ "$ans" = "Y" ] || [ "$ans" = "y" ]; then
    python3 get_proxy.py 10
else
    echo "Proxy list is not update"
fi

cat good_proxies_list.txt >> $file

if [ ! -f "/etc/bakproxychains.conf" ] ; then
    cp /etc/proxychains.conf /etc/bakproxychains.conf
    cp proxychains.conf /etc/proxychains.conf
else
    cp proxychains.conf /etc/proxychains.conf
fi


#Append argument to proxychains
for i in $*;
do
    params=" $params $d $i"
done
proxychains $params