require 'uri'
require 'net/http'

class Controller
  attr_accessor :url
  attr_accessor :output
  attr_accessor :api_version
  
  API_V1_HEADERS = "Accept: application/vnd.playup.sport ;"
  
  def awakeFromNib
  end  
  
  def hitUrl(sender)   
    uri = URI.parse(url.stringValue)
    request = Net::HTTP::Get.new(uri.path)    

    headers = ""
    
    if api_version.selectedCell.tag == 1
      headers = API_V1_HEADERS
    end
    
    headers.split(/;/).each do |header|
      key, value = header.split(/:/)
      key.strip!
      value.strip!
      request.add_field(key, value)
    end
      
    response = Net::HTTP.new(uri.host).start do |http|
      http.request(request)
    end
                                
    output.string = response.body
    output.textStorage.font = NSFont.fontWithName("Andale Mono", size:12.0)
  end
end