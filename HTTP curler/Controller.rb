require 'uri'
require 'net/http'

class Controller
  attr_accessor :url
  attr_accessor :output
  attr_accessor :headers
  
  def awakeFromNib
  end  
  
  def hitUrl(sender)
    output.string = ""
    
    uri = URI.parse(url.stringValue)
    request = Net::HTTP::Get.new(uri.path)    
    
    if headers
     headers.stringValue.split(/;/).each do |header|
        key, value = header.split(/:/)
        key.strip!
        value.strip!
        request.add_field(key, value)
      end
    end
      
    response = Net::HTTP.new(uri.host).start do |http|
      http.request(request)
    end
                                
    output.string = response.body                                
  end
end