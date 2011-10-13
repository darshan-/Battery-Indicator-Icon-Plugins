#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 plugin-name"
    exit
fi

plugin_name=$1
plugin_full_name=`ruby -e "puts '$plugin_name'.gsub(/([A-Z])/, ' \1').strip"`
plugin_dir=plugin-$1

cp -ar skeleton-plugin-dir $plugin_dir

cd $plugin_dir

sed -i -e s/PluginName/$plugin_name/ AndroidManifest.xml
sed -i -e s/PluginName/$plugin_name/ src/com/darshancomputing/BatteryIndicatorPro/IconPlugin/PluginService.java
sed -i -e "s/PluginName/$plugin_full_name/" res/values/strings.xml

git add .
