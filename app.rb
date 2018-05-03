require "./lib/ipsw/device_list"
require "./lib/ipsw/identifier"
require "set"
require "awesome_print"

# class UpdateFirmware

#     IPSW_DIRECTORY = ""

#     attr_accessor :devices, :urls

#     def initialize
#         @devices = IPSW::DeviceList.new(only: "iPhone")
#         @urls = Set.new
#     end

#     def update!
#         devices.identifiers.each do |identifier|
#             firmware = IPSW::Identifier.new(identifier)
#             urls << firmware.latest[:url]
#             firmware.previous.each do |firmware|
#                     if File.exists?(firmware[:file_name])
#                         puts "Deleting #{firmware[:file_name]}..."
#                         File.delete(firmware[:file_name])
#                     end
#                 end
#             end
#         end
#     end

#     def write_to_file
#         File.open("urls.txt", "w") do |file|
#             file.write(urls.to_a.join("\n"))
#         end
#     end

# end

IPSW_DIRECTORY = ""

devices = IPSW::DeviceList.new(only: "iPad")

urls  = Set.new

new_files = []
old_files = Dir["*.ipsw"]

devices.identifiers.each do |identifier|
    firmware = IPSW::Identifier.new(identifier)
    puts "LATEST: " + firmware.latest[:name]
    urls      << firmware.latest[:url]
    new_files << firmware.latest[:name]
end

(old_files - new_files).each do |file|
    if File.exists?(file)
        puts "Deleting #{file}..."
        File.delete(file)
    end
end

File.open("urls.txt", "w") do |file|
    file.write(urls.to_a.join("\n"))
end