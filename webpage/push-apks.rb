#!/usr/bin/env ruby
# encoding: utf-8

project = 'battery-indicator'
user = `cat ~/.netrc | awk '{print $4;}'`.strip
pass = `cat ~/.netrc | awk '{print $6;}'`.strip

system("rm apks/*")

Dir.glob('../plugin-*').each do |plugin_dir|
  name = plugin_dir.split('../plugin-').last
  version = `grep "android:versionName=" #{plugin_dir}/AndroidManifest.xml`.split('"')[1]
  apk_location = "./apks/BIPlugin-#{name}-#{version}.apk"

  system("cp #{plugin_dir}/bin/*-release.apk #{apk_location}")
  system("./googlecode_upload.py --summary=. --project=#{project} --user=#{user} --password=#{pass} #{apk_location}")
end
