#!/usr/bin/env ruby
# encoding: utf-8

require 'erb'
require './dsts-ext.rb'

plugins = Array.new

$order = ['BlackSquare', 'BlackCircle']

system("rm -f icons/*")

GC_DOWNLOAD_URL = 'http://battery-indicator.googlecode.com/files'

def icon(icon_name)
  $icon.call(icon_name)
end

Dir.glob('../plugin-*').each do |plugin_dir|
  name = plugin_dir.split('../plugin-').last
  version = `grep "android:versionName=" #{plugin_dir}/AndroidManifest.xml`.split('"')[1]
  apk_name = "BIPlugin-#{name}-#{version}.apk"
  png_location = "./icons/BIPlugin-#{name}-default050.png"
  chg_location = "./icons/BIPlugin-#{name}-charging050.png"

  raw_summary = IO.read("#{plugin_dir}/summary.rhtml").gsub(/\n\n/, "</p>\n\n<p>")

  # Used in rhtml summaries
  $icon = lambda do |icon_name|
    icon_name << ".png"
    icon_loc = "./icons/#{name}-#{icon_name}"
    system "cp #{plugin_dir}/res/drawable-hdpi/#{icon_name} #{icon_loc} &>/dev/null"

    %Q{<br /><div class="status_bar black"><img src="#{icon_loc}" />
       </div><div class="status_bar pre_gingerbread"><img src="#{icon_loc}" /></div>\n}
  end

  plugin = Hash.new

  plugin[:name] = name
  plugin[:version] = version
  plugin[:apk_name] = apk_name
  plugin[:png_location] = png_location
  plugin[:chg_location] = chg_location
  plugin[:summary] = ERB.new(raw_summary).result(binding())

  plugins << plugin
end

plugins.sort! do |p1, p2|
  if not $order.include?(p1[:name]) and not $order.include?(p2[:name])
    0
  elsif not $order.include?(p2[:name]) or ($order.include?(p1[:name]) and $order.index(p1[:name]) < $order.index(p2[:name]))
    -1
  else
    1
  end
end

page = PluginPage.new
page.title = 'Battery Indicator Pro Icon Plugins'

plugins.each do |plugin|
  page.addln "<h2>#{plugin[:name]}</h2>"
  page.addln "<p>#{plugin[:summary]}</p>"
  page.addln %Q{<a href="#{GC_DOWNLOAD_URL}/#{plugin[:apk_name]}">Download #{plugin[:name]}-#{plugin[:version]}</a>}
  page.addln "<hr />"
end

File.open('plugins.html', 'w') do |f|
  f.puts(page.generate())
end
