#!/bin/bash

read -p "You want to update proxy list(y/N): " ans

if [ "$ans" = "Y" ] || [ "$ans" = "y" ]; then
    python3 get_proxy.py 10
    #Clearn tmp file
    rm -rf proxies_new_proxy_list.txt
else
    echo "Proxy list is not update"
fi

#Proccess config file
python3 file_utils.py

#Append argument to proxychains
for i in $*;
do
    params=" $params $d $i"
done
proxychains $params

#Restore config file
mv /etc/bakproxychains.conf  /etc/proxychains.conf 


