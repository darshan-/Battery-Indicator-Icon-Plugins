#!/bin/bash

project="battery-indicator"
user=`cat ~/.netrc | awk '{print $4;}'`
pass=`cat ~/.netrc | awk '{print $6;}'`

for apk in apks/*.apk
do
    ./googlecode_upload.py --summary=. --project=$project --user=$user --password=$pass $apk
done
