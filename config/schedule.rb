every 5.minutes do
    # Update urls in text file
    # firmware = FetchLatestFirmware.new
    # firmware.update!
end

# Download files from text file
every 10.minutes do
    command `aria2
                --continue
                --allow-overwrite=false
                --always-resume=true
                --conditional-get=true
                --input urls.txt`
end