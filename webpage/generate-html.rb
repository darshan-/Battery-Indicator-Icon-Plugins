# -*- coding: utf-8 -*-

#require 'nokogiri'
require './dsts-ext.rb'

plugins = Array.new

Dir.glob('../plugin-*').each do |plugin_dir|
  name = plugin_dir.split('../plugin-').last
  location = "./BIPlugin-#{name}.apk"

  system "cp #{plugin_dir}/bin/*-release.apk #{location}"

  plugin = Hash.new

  plugin[:name] = name
  plugin[:location] = location

  plugins << plugin
end

page = PluginPage.new
page.addln '<ul>'

plugins.each do |plugin|
  page.addln "<li><a href=\"#{plugin[:location]}\">#{plugin[:name]}</a></li>"
end

page.addln '</ul>'

File.open('plugins.html', 'w') do |f|
  f.puts(page.generate())
end
