require "net/http"
require "uri"

module Publishers
  class Discord
    def post(text, image_path)
      webhook = ENV["DISCORD_WEBHOOK"]

      return false unless webhook

      uri = URI(webhook)
      req = Net::HTTP::Post.new(uri)

      form = [
        ["content", text],
        ["file", File.open(image_path)]
      ]

      req.set_form form, "multipart/form-data"

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    end
  end
end