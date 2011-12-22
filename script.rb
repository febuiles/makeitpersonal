require 'rubygems'
require 'nokogiri'
require 'open-uri'

user = "febuiles"
url = "http://ws.audioscrobbler.com/2.0/user/#{user}/recenttracks.xml?limit=200"
doc = Nokogiri::XML(open(url))
doc.css("recenttracks").css("track").each do |track|
  artist = track.css("artist").first.content
  name  = track.css("name").first.content
  puts "#{artist} - #{name}"
end
