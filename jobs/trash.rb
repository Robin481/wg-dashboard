require 'net/http'
require 'json'

SCHEDULER.every '10h' do

  # Grab paper dates
  url = ENV['TRASH_URL']
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  text = response.body

  trashArray = text.scan(/\w{2},\s\d{2}\.\s\w{3}.\s\d{4},\s\d{2}:\d{2}/)

  trashArray = trashArray[0, 2]

  send_event('trash', { trash: trashArray })
end
