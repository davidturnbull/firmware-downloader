require "./device_list"

IPSW_DIRECTORY = ""

devices = IPSW::DeviceList.new(only: "iPhone")

firmware_urls = Set.new

devices.identifiers.each do |identifier|
    firmware = IPSW::Identifier.new(identifier)
    firmware_urls << firmware.latest[:url]
    firmware.previous.each do |firmware|
            if File.exists?(firmware[:file_name])
                puts "Deleting #{firmware[:file_name]}..."
                File.delete(firmware[:file_name])
            end
        end
    end
end

File.open("urls.txt", "w") do |file|
    file.write(firmware_urls.to_a.join("\n"))
end