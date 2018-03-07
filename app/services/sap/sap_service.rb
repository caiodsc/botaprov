require 'json'
require 'rest-client'
require 'net/http'
class SapService
  class << self

    def get_emailmatricula(email)
      data = {
          :I_EMAIL => email
      }
      p @emailmatricula
      result = sap('ZBOT_EMAIL_MATRICULA', data)
      result
      #JSON.parse(result)
    end

    private
    def sap(resource, data = {})
      begin
        uri = URI.parse("http://180.200.3.18/sap/" + resource)
        http = Net::HTTP.new(uri.host,4567)
        request = Net::HTTP::Post.new(uri.request_uri)
        request.basic_auth 'bemol', 'PyRV8uTDkfjS3aUL'
        request.body = data.to_json
        JSON.parse(http.request(request).body)
      rescue
        Exception
      end
    end
    def server(resource)
      begin
        uri = URI.parse("http://180.200.1.231/" + resource)
        http = Net::HTTP.new(uri.host,4567)
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth 'bemolPVM', 'pvm2012'
        JSON.parse(http.request(request).body)
      rescue
        Exception
      end
    end
  end
end

p SapService.get_emailmatricula("franciscomedeiros@bemol.com.br")