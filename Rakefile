require "set"
require "./lib/ipsw/device_list"
require "./lib/ipsw/identifier"

task :default => [:update]

task :update do

    models = File.readlines("models.txt").map do |model|
        model.strip
    end

    devices = IPSW::DeviceList.new(include: models)

    urls  = Set.new

    new_files = []
    old_files = Dir["/root/files/*.ipsw"]

    devices.identifiers.each do |identifier|
        firmware = IPSW::Identifier.new(identifier)
        urls      << firmware.latest[:url]
        new_files << "/root/files/" + firmware.latest[:name]
        puts firmware.latest[:name]
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
