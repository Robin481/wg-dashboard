require 'net/http'
require 'json'

SCHEDULER.every '15m', :first_in => 0 do |job|

  uri = URI.parse("https://icanhazdadjoke.com/")
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/json"

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  data = JSON.parse(response.body)
  quote = data["joke"]

  send_event('quote', { quote: quote})
end
