require "net/http"
require "uri"

module Publishers
  class Discord
    def post(text, image_path)
      webhook = ENV["DISCORD_WEBHOOK"]

      exit unless webhook

      uri = URI(webhook)
      req = Net::HTTP::Post.new(uri)

      form = [
        ["content", text],
        ["file", File.open(image_path)]
      ]

      req.set_form form, "multipart/form-data"

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

     return res.code.to_i == 200
    end
  end
end