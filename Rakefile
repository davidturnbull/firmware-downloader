require "set"
require "./lib/ipsw/device_list"
require "./lib/ipsw/identifier"

task :update do

    devices = IPSW::DeviceList.new(only: "iPad", except: "GSM, CDMA, iPad 1, China")

    urls  = Set.new

    new_files = []
    old_files = Dir["*.ipsw"]

    devices.identifiers.each do |identifier|
        firmware = IPSW::Identifier.new(identifier)
        puts firmware.latest[:name] unless new_files.include? firmware.latest[:name]
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

end
