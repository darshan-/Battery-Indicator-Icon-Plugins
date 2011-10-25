require './dsts.rb'

class PluginPage < XhtmlPage
  def initialize()
    super()
    @style_sheets = ['plugins.css']
    @head_misc << %Q{<meta name="HandheldFriendly" content="true" />\n}
    @head_misc << %Q{<meta name="viewport" content="width=device-width, height=device-height, user-scalable=no" />}
  end

  def open_body()
    super()

    #@page << %Q{<div id="centered_page_wrapper">}
    #@page << %Q{<div class="main_box">}
  end

  def close_body()
    #@page << %Q{</div></div>}
    super()
  end
end
