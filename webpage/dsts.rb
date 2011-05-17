# Darshan's Simple Template System

# Version 6

# On gentoo, this should reside at: /usr/lib/ruby/site_ruby/1.8/dsts.rb
#   (not sure for other systems; maybe the same place?)

# TODO:
#
#  support stylesheet titles?
#  external js

begin
  require 'RMagick'
  RMagick = true
rescue LoadError
  RMagick = false
end

# Useless on its own -- use XhtmlPage or Html5Page
class AbstractPage
  attr_accessor :title, :encoding, :style_sheets, :javascripts, :head_misc, :body_tag_misc
  attr_accessor :options

  def initialize()
    @content = ""
    @title = ""
    @encoding = 'utf-8'
    @style_sheets = []  # Array of (string) paths to stylesheets
    @javascripts = []   # Not yet implemented
    @head_misc = ""     # Anything else to go in head section (eg inline js)
    @body_tag_misc = "" # Anything else to go in body tag (eg onload=)

    # @options holds booleans for whether or not we should automatically
    #  generate particular feature on page
    @options = Hash.new
    @options['w3c_buttons'] = false
    @options['gen_time'] = false
    @options['alternate_time'] = nil # time to use instead of Time.now
  end

  def add(s)
    @content << s
  end

  def generate()
    @page = String.new

    print_header()
    print_content()
    print_footer()

    @page
  end

  def img(f, alt=nil)
    alt = f if alt.nil?
    dims = ""

    if RMagick
      img = Magick::Image::ping(f)[0]
      w = img.columns
      h = img.rows
      dims = "width=\"#{w}\" height=\"#{h}\" "
    end

    return "<img src=\"#{f}\" alt=\"#{alt}\" #{dims}/>"
  end

  protected

  def print_content()
    @page << @content
  end

  def print_header()
    open_page()
    @page << @head_misc
    open_body()
  end

  def print_footer()
    close_body()
    close_page()
  end

  def open_page()
  end

  def print_style_links()
    @style_sheets.each do |ss|
      @page << %Q{<link rel="stylesheet" href="#{ss}" type="text/css" />\n}
    end
  end

  def open_body()
    if !@body_tag_misc.empty?
      s = " " << @body_tag_misc
    end
    @page << "</head>\n<body#{s}>\n"
  end

  def print_w3c_buttons()
  end

  def print_gen_time()
    @page << %Q{
<p style="margin-top: 10px; margin-bottom: 0px;">
This page was last generated #{@options['alternate_time'] or Time.now}
</p>
}
  end

  def close_body()
    print_w3c_buttons() if @options['w3c_buttons']
    print_gen_time() if @options['gen_time']
    @page << "</body>\n"
  end

  def close_page()
    @page << "</html>\n"
  end

  def strip_tags(s)
    s.gsub(/(<.*?>)/, "")
  end
end

# Supports doctype of "strict" and "transitional"
class XhtmlPage < AbstractPage
  attr_accessor :doctype
  def initialize()
    super()
    @title = 'XHTML Page'
    @doctype = 'strict'
  end

  def open_page()
    @page << %Q{<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 #{doctype.capitalize}//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-#{doctype.downcase}.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://www.w3.org/2005/10/profile">
<title>#{strip_tags @title}</title>
<meta http-equiv="Content-Type" content="text/html; charset=#{encoding}" />
}
    print_style_links()
  end

  def print_w3c_buttons()
    @page << %Q{
<p style="clear: both" />
<p style="margin-bottom: 0px;">
  <a href="http://validator.w3.org/check?uri=referer"><img
    src="http://darshancomputing.com/valid-icons/valid-xhtml10.png"
    alt="Valid XHTML 1.0!" height="31" width="88" /></a>
  <a href="http://jigsaw.w3.org/css-validator/check/referer"><img
    src="http://darshancomputing.com/valid-icons/vcss.png"
    alt="Valid CSS!" height="31" width="88" /></a>
</p>
}
  end
end

class Html5Page < AbstractPage
  def initialize()
    super()
    @title = 'HTML5 Page'
  end

  def open_page()
    @page << %Q{<!DOCTYPE html>
<html>
<head>
<title>#{strip_tags @title}</title>
<meta http-equiv="Content-Type" content="text/html; charset=#{encoding}" />
}
    print_style_links()
  end
end
