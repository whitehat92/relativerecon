#!/bin/bash
if [ ! -d $(echo $1 | sed 's/https:\/\///g' | sed "s/\//_/g") ]; then
mkdir $(echo $1 | sed 's/https:\/\///g' | sed "s/\//_/g")
fi
if [ -d "$(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')" ]; then
echo "success" > $(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')/success.txt
fi
echo "running curl"
curl -iLs $1 > $(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')/curl.txt
echo "running dirsearch"
#/usr/bin/dirsearch $1 > $(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')/directories.txt
python3 /root/tools/dirsearch_new/dirsearch/dirsearch.py -u $1 -e html,htm,js,php,conf,dist,cnf,info,sql,asp,net,aspnet,dst,mysql,doc,pdf,xls,info,inf,txt,odt,php3,php4,php5,phtml,lib,test,inc,index,war,foo,rdz,zip,7z,.html,.htm,.js,.php,.conf,.dist,.cnf,.info,.sql,.asp,.net,.aspnet,.dst,.mysql,.doc,.pdf,.xls,.info,.inf,.txt,.odt,.php3,.php4,.php5,.phtml,.lib,.test,.inc,.index,.war,.foo,.rdz,.zip,.7z -t 10 -F -b -r --plain-text-report=$(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')/directories.txt
if grep -i "server: " $(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')/curl.txt; then
grep -i "server: " $(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g' )/curl.txt | awk -F ":" '{print $2}' > $(echo $1 | sed 's/https:\/\///g' | sed 's/\//_/g')/server.txt
fi

#bash relativerecon.sh example.com/something
