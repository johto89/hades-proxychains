#!/bin/bash

cat << "EOF"
-------------------------------------------------------------
 _   _           _                                            
| | | |         | |                                           
| |_| | __ _  __| | ___  ___                                  
|  _  |/ _` |/ _` |/ _ \/ __|                                 
| | | | (_| | (_| |  __/\__ \                                 
\_| |_/\__,_|\__,_|\___||___/                                 
                                                                                                                            
       ______                         _           _           
       | ___ \                       | |         (_)          
       | |_/ / __ _____  ___   _  ___| |__   __ _ _ _ __  ___ 
       |  __/ '__/ _ \ \/ / | | |/ __| '_ \ / _` | | '_ \/ __|
       | |  | | | (_) >  <| |_| | (__| | | | (_| | | | | \__ \
       \_|  |_|  \___/_/\_\\__, |\___|_| |_|\__,_|_|_| |_|___/
                            __/ |                             
                           |___/                              

©Copyright: Johto Robbie. ( @johto1989 | vnhackernews.com )
-------------------------------------------------------------
EOF

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

program="proxychains"
command -v "${program}"

if [[ "${?}" -ne 0 ]]; then
    printf "${program} is not installed, exiting\\n"
    exit 1
else
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
fi 






