# Update URLS
every 5.minutes do
    rake "update"
end

# Download files from text file
every 10.minutes do
    # TODO: Make directories if they don't exist
    command "aria2c --continue --allow-overwrite=false --always-resume=true --input=/root/app/urls.txt --dir=/root/files"
end
