require "set"
require "./lib/ipsw/device_list"
require "./lib/ipsw/identifier"

# TODO: Set the default task to "update" task

task :update do

    devices = IPSW::DeviceList.new(only: "iPhone, iPad")

    urls  = Set.new

    new_files = []
    old_files = Dir["/mnt/volume-sfo2-01/*.ipsw"]

    devices.identifiers.each do |identifier|
        firmware = IPSW::Identifier.new(identifier)
        puts firmware.latest[:name] unless new_files.include? firmware.latest[:name]
        urls      << firmware.latest[:url]
        new_files << "/mnt/volume-sfo2-01/" + firmware.latest[:name]
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
    
     File.open("/root/public/urls.txt", "w") do |file|
        file.write(new_files.join("\n"))
    end

end
