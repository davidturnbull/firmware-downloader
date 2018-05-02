require "httparty"
require "set"
require "json"
require "uri"

devices_url = "https://api.ipsw.me/v4/devices"

devices_response = HTTParty.get(devices_url)

devices = JSON.parse(devices_response.body)

identifiers = devices.map do |device|
    if device["identifier"] =~ /iPhone|iPad/
        device["identifier"]
    end
end.compact

urls = Set.new

identifiers.each do |identifier|
    identifier_url = "https://api.ipsw.me/v4/device/#{identifier}?type=ipsw"
    identifier_response = JSON.parse(HTTParty.get(identifier_url).body)
    puts "Fetching latest firmware URL for #{identifier_response["name"]}..."
    urls << identifier_response["firmwares"].first["url"]
end

file_name = "urls.txt"

File.open(file_name, "w") do |file|
    file.write(urls.to_a.join("\n"))
end

puts "Finished adding #{identifiers.length} URLs to #{file_name}"