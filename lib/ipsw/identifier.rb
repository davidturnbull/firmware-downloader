require "httparty"
require "uri"
# require "awesome_print"

module IPSW

  class Identifier

    IDENTIFIER_FORMAT = /(iPad|iPhone)\d,\d/

    attr_accessor :identifier, :request

    def initialize(identifier)
      @identifier = normalize(identifier)
    #   @response   = HTTParty.get(endpoint) if valid?
      @request = HTTParty.get(endpoint)
    end

    def valid?
      identifier.match?(IDENTIFIER_FORMAT)
    end

    def endpoint
      "https://api.ipsw.me/v4/device/#{identifier}?type=ipsw"
    end

    # def json
    #     ap response
    #     JSON.parse(response)
    # end

    def list
      response["firmwares"].map do |item|
        {
          name: extract_file_name(item["url"]),
          url:  item["url"]
        }
      end
    end

    def latest
      list.first
    end

    def previous
        list.drop(1)
    end

    def name(extension: true)
      extension ? latest[:name] : File.basename(latest[:name], ".*")
    end

    def device
      response["name"]
        .gsub(/\(.*\)/, "")
        .sub("+", " Plus")
        .strip
    end

    private

    def response
        if request.code === 200
            JSON.parse(request.body)
        else
            raise "Request to #{ENDPOINT} returned a response code of #{request.code}"
        end
    end

      def normalize(string)
        string
          .gsub(/\s/, "")
          .sub("ipad", "iPad")
          .sub("iphone", "iPhone")
      end

      def extract_file_name(url)
        uri = URI.parse(url)
        File.basename(uri.path)
      end

  end

end