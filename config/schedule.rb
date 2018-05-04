# require "ptools"

every 5.minutes do
    rake "update"
end

# Download files from text file
every 10.minutes do
#     if File.which("aria2c")
        command "aria2c \
                    --continue \
                    --allow-overwrite=false \
                    --always-resume=true \
                    --input=/root/firmware-downloader/urls.txt \
                    --dir=/mnt/volume-sfo2-01"
#     else
#         raise "aria2 is required to download files. Download here: https://aria2.github.io"
#     end
end
