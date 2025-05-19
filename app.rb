require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require_relative "validate_hex"

get("/") do
  @fg_color = "d473c0"
  @bg_color = "511c29"
  @original_fg_color = "d473c0"
  @original_bg_color = "511c29"
  @error_message = nil

  request_colors_apis(@fg_color, @bg_color)
  
  erb(:home)
end

get("/check_contrast") do
  raw_fg_color = params.fetch("foreground_color").gsub("#", "")
  raw_bg_color = params.fetch("background_color").gsub("#", "")

  # Check if foreground color is a valid hex color
  if validate_hex(raw_fg_color)
    @fg_color = raw_fg_color
    @original_fg_color = raw_fg_color
    @fg_error_message = nil
  else
    @fg_color = "000000"
    @original_fg_color = raw_fg_color
    @fg_error_message = "Oops! Invalid hex code"
  end

  # Check if background color is a valid hex color
  if validate_hex(raw_bg_color)
    @bg_color = raw_bg_color
    @original_bg_color = raw_bg_color
    @bg_error_message = nil
  else
    @bg_color = "ffffff"
    @original_bg_color = raw_bg_color
    @bg_error_message = "Oops! Invalid hex code"
  end


  request_colors_apis(@fg_color, @bg_color)

  erb(:home)
end


def request_colors_apis(fg_color, bg_color)
  # Request color api to get hex color name and corresponding contrast value
  fg_api_url = "https://www.thecolorapi.com/id?hex=#{fg_color}"
  fg_api_response = HTTP.get(fg_api_url)
  fg_api_parsed = JSON.parse(fg_api_response)
  bg_api_url = "https://www.thecolorapi.com/id?hex=#{bg_color}"
  bg_api_response = HTTP.get(bg_api_url)
  bg_api_parsed = JSON.parse(bg_api_response)

  @fg_name = fg_api_parsed["name"]["value"]
  @fg_contrast_value = fg_api_parsed["contrast"]["value"]
  @bg_name = bg_api_parsed["name"]["value"]
  @bg_contrast_value = bg_api_parsed["contrast"]["value"]

  # Request contrast checker api to get contrast ratio and pass/fail statements for AA and AAA for normal and large text 
  webaim_api_url = "https://webaim.org/resources/contrastchecker/?fcolor=#{fg_color}&bcolor=#{bg_color}&api"
  webaim_api_response = HTTP.get(webaim_api_url)
  webaim_api_parsed = JSON.parse(webaim_api_response)

  @ratio = webaim_api_parsed["ratio"].to_f
  @aa = webaim_api_parsed["AA"].to_s
  @aa_large = webaim_api_parsed["AALarge"].to_s
  @aaa = webaim_api_parsed["AAA"].to_s
  @aaa_large = webaim_api_parsed["AAALarge"].to_s

end
