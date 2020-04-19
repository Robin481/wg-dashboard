require 'net/http'
require 'json'

SCHEDULER.every '1h', :first_in => 0 do |job|

  url = "https://randomfox.ca/floof/"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  fox = data["image"]

  send_event('cats', { url: fox })
end
