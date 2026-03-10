require "net/http"
require "json"

module Publishers
  class Mastodon
    def post(text, image_path)
      instance = ENV["MASTODON_INSTANCE"]
      token    = ENV["MASTODON_TOKEN"]

      exit unless instance && token

      abort "Image not found" unless File.exist?(image_path)

      uri = URI("#{instance}/api/v1/media")

      req = Net::HTTP::Post.new(uri)
      req["Authorization"] = "Bearer #{token}"

      form_data = [
        ["file", File.open(image_path), { filename: "rsn_events.png" }]
      ]

      req.set_form form_data, "multipart/form-data"

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

      media = JSON.parse(res.body)
      media_id = media["id"]

      uri = URI("#{instance}/api/v1/statuses")

      req = Net::HTTP::Post.new(uri)
      req["Authorization"] = "Bearer #{token}"

      req.set_form_data(
        "status" => text,
        "media_ids[]" => media_id
      )

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    end
  end
end