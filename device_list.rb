module IPSW

    class DeviceList

        ENDPOINT = "https://api.ipsw.me/v4/devices"

        attr_accessor :request, :only, :except

        def initialize(only: nil, except: nil)
            @request = HTTParty.get(ENDPOINT)
            @only    = regexify(only)
            @except  = regexify(except)
        end

        def list
            whitelisted_devices - blacklisted_devices
        end

        def names
            list.map { |device| device["name"] }
        end

        def identifiers
            list.map { |device| device["identifier"] }
        end

        private

            def regexify(value)
                value && Regexp.new(value.to_s.split(",").join("|").gsub(/\|\s/, "|"))
            end

            def response
                if request.code === 200
                    JSON.parse(request.body)
                else
                    raise "Request to #{ENDPOINT} returned a response code of #{request.code}"
                end
            end

            def whitelisted_devices
                response.select do |device|
                    only ? only.match(device["name"]) : device
                end
            end
        
            def blacklisted_devices
                response.select do |device|
                    except && except.match(device["name"])
                end
            end

    end

end