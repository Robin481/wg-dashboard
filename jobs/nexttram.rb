#!/usr/bin/env ruby

require 'net/http'
require 'json'

SCHEDULER.every '30s', :first_in => 0 do |job|

  url = ENV["TRANSPORT_QUERY"]
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  timeArray = []

  data["connections"].each do|tram|
    nexttram = tram["from"]["departure"]
    two = nexttram.split('T')
    one = two[1]
    time = one[0..4]
    timeArray.push(time)
  end
  puts timeArray

  send_event('nexttram', { time: timeArray })
end
