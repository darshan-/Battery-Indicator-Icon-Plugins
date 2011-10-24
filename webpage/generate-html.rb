#!/usr/bin/env ruby
# encoding: utf-8

require 'erb'
require './dsts-ext.rb'

plugins = Array.new

system("rm icons/*")

GC_DOWNLOAD_URL = 'http://battery-indicator.googlecode.com/files'

Dir.glob('../plugin-*').each do |plugin_dir|
  name = plugin_dir.split('../plugin-').last
  version = `grep "android:versionName=" #{plugin_dir}/AndroidManifest.xml`.split('"')[1]
  apk_name = "BIPlugin-#{name}-#{version}.apk"
  png_location = "./icons/BIPlugin-#{name}-default050.png"
  chg_location = "./icons/BIPlugin-#{name}-charging050.png"

  if not (system "cp #{plugin_dir}/res/drawable-hdpi/default050.png #{png_location} &>/dev/null")
    png_location = nil
  end
  if not (system "cp #{plugin_dir}/res/drawable-hdpi/charging050.png #{chg_location} &>/dev/null")
    chg_location = nil
  end

  plugin = Hash.new

  plugin[:name] = name
  plugin[:apk_name] = apk_name
  plugin[:png_location] = png_location
  plugin[:chg_location] = chg_location
  plugin[:summary] = ERB.new(IO.read("#{plugin_dir}/summary.rhtml")).result(binding())

  plugins << plugin
end

page = PluginPage.new
page.title = 'Battery Indicator Pro Icon Plugins'

plugins.each do |plugin|
  page.addln "<h2>#{plugin[:name]}</h2>"
  page.addln "<p>#{plugin[:summary]}</p>"
  page.addln %Q{<a href="#{GC_DOWNLOAD_URL}/#{plugin[:apk_name]}">Download #{plugin[:apk_name]}</a>}
  page.addln "<hr />"
end

page.addln '<table><tr><th>Name</th><th colspan="2">Normal Icon</th><th colspan="2">Charging Icon</th><th>Link</th></tr>'
plugins.each do |plugin|
  page.add '<tr>'
  page.add "<td>#{plugin[:name]}</td>"
  page.add "<td style=\"text-align:center; background-color:black;\"><img src=\"#{plugin[:png_location]}\"></td>"
  page.add "<td style=\"text-align:center; background-image:url('./images/pre-gingerbread-bg.png')\"><img src=\"#{plugin[:png_location]}\"></td>"
  if plugin[:chg_location].nil?
    page.add '<td colspan="2">(No change)</td>'
  else
    page.add "<td style=\"text-align:center; background-color:black\"><img src=\"#{plugin[:chg_location]}\"></td>"
    page.add "<td style=\"text-align:center; background-image:url('./images/pre-gingerbread-bg.png')\"><img src=\"#{plugin[:chg_location]}\"></td>"
  end
  #page.add "<td><a href=\"#{plugin[:apk_location]}\">#{plugin[:apk_location].split('/').last}</a></td>"
  page.add "<td><a href=\"#{plugin[:apk_location]}\">Install</a></td>"
  page.addln "</tr>"
end

page.addln '</table>'

File.open('plugins.html', 'w') do |f|
  f.puts(page.generate())
end
