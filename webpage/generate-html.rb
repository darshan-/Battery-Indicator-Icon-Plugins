# -*- coding: utf-8 -*-

#require 'nokogiri'
require './dsts-ext.rb'

plugins = Array.new

Dir.glob('../plugin-*').each do |plugin_dir|
  plugins << plugin_dir.split('../plugin-').last
end

page = PluginPage.new
page.add '<ul>'

plugins.each do |plugin|
  page.add '<li>' << plugin << '</li>'
end

page.add '</ul>'

File.open('plugins.html', 'w') do |f|
  f.puts(page.generate())
end
