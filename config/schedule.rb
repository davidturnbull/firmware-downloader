require "ptools"

every 5.minutes do
    # Update urls in text file
    # firmware = UpdateFirmware.new
    # firmware.update!
end

# Download files from text file
every 10.minutes do
    if File.which("aria2c")
        command `aria2c
                    --continue
                    --allow-overwrite=false
                    --always-resume=true
                    --conditional-get=true
                    --input urls.txt`
    else
        raise "aria2 is required to download files. Download here: https://aria2.github.io"
    end
end