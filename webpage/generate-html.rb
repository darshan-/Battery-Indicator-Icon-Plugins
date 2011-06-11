# -*- coding: utf-8 -*-

#require 'nokogiri'
require './dsts-ext.rb'

plugins = Array.new

Dir.glob('../plugin-*').each do |plugin_dir|
  name = plugin_dir.split('../plugin-').last
  apklocation = "./apks/BIPlugin-#{name}.apk"
  pnglocation = "./images/BIPlugin-#{name}-default050.png"
  chglocation = "./images/BIPlugin-#{name}-charging050.png"

  system "cp #{plugin_dir}/bin/*-release.apk #{apklocation}"
  system "cp #{plugin_dir}/res/drawable-hdpi/default050.png #{pnglocation}"
  if not (system "cp #{plugin_dir}/res/drawable-hdpi/charging050.png #{chglocation} &>/dev/null")
    chglocation = nil
  end

  plugin = Hash.new

  plugin[:name] = name
  plugin[:apklocation] = apklocation
  plugin[:pnglocation] = pnglocation
  plugin[:chglocation] = chglocation

  plugins << plugin
end

page = PluginPage.new
page.addln '<ul>'

page.addln '<table><tr><th>Name</th><th colspan="2">Normal Icon</th><th colspan="2">Charging Icon</th><th>Link</th></tr>'
plugins.each do |plugin|
  page.add '<tr>'
  page.add "<td>#{plugin[:name]}</td>"
  page.add "<td style=\"text-align:center; background-color:black;\"><img src=\"#{plugin[:pnglocation]}\"></td>"
  page.add "<td style=\"text-align:center; background-image:url('./images/pre-gingerbread-bg.png')\"><img src=\"#{plugin[:pnglocation]}\"></td>"
  if plugin[:chglocation].nil?
    page.add '<td colspan="2">(Same)</td>'
  else
    page.add "<td style=\"text-align:center; background-color:black\"><img src=\"#{plugin[:chglocation]}\"></td>"
    page.add "<td style=\"text-align:center; background-image:url('./images/pre-gingerbread-bg.png')\"><img src=\"#{plugin[:chglocation]}\"></td>"
  end
  #page.add "<td><a href=\"#{plugin[:apklocation]}\">#{plugin[:apklocation].split('/').last}</a></td>"
  page.add "<td><a href=\"#{plugin[:apklocation]}\">Install</a></td>"
  page.addln "</tr>"
end

page.addln '</table>'

File.open('plugins.html', 'w') do |f|
  f.puts(page.generate())
end
