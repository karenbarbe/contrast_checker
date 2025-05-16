require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  # @foreground_color = params.fetch("foreground_color")
  @fg_color = "d473c0"
  @bg_color = "f4f4f1"

  fg_api_url = "https://www.thecolorapi.com/id?hex=#{@fg_color}"
  fg_api_response = HTTP.get(fg_api_url)
  fg_api_parsed = JSON.parse(fg_api_response)
  bg_api_url = "https://www.thecolorapi.com/id?hex=#{@bg_color}"
  bg_api_response = HTTP.get(bg_api_url)
  bg_api_parsed = JSON.parse(bg_api_response)

  @fg_name = fg_api_parsed["name"]["value"]
  @fg_contrast_value = fg_api_parsed["contrast"]["value"]
  @bg_name = bg_api_parsed["name"]["value"]
  @bg_contrast_value = bg_api_parsed["contrast"]["value"]

  webaim_api_url = "https://webaim.org/resources/contrastchecker/?fcolor=#{@fg_color}&bcolor=#{@bg_color}&api"
  webaim_api_response = HTTP.get(webaim_api_url)
  webaim_api_parsed = JSON.parse(webaim_api_response)

  @ratio = webaim_api_parsed["ratio"]
  @aa = webaim_api_parsed["AA"]
  @aa_large = webaim_api_parsed["AALarge"]
  @aaa = webaim_api_parsed["AAA"]
  @aaa_large = webaim_api_parsed["AAALarge"]
  

  erb(:home)
end
