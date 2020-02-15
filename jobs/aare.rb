#!/usr/bin/env ruby
require 'open-uri'
require 'json'
require 'net/http'

SCHEDULER.every '30m', :first_in => 0 do |job|
  source = ("https://aareguru.existenz.ch/v2018/today")
  resp = Net::HTTP.get_response(URI.parse(source))
  data = resp.body
  result = JSON.parse(data)

  send_event('aare', { temperature: result["aare"].to_s, text: result["text"] })
end
