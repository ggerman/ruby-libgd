require "net/http"
require "json"

instance = ENV["MASTODON_INSTANCE"]
token    = ENV["MASTODON_TOKEN"]

image = "demo/rsn_events_bot/rsn_events.png"

# subir media
uri = URI("#{instance}/api/v2/media")

req = Net::HTTP::Post.new(uri)
req["Authorization"] = "Bearer #{token}"

form = [["file", File.open(image)]]
req.set_form form, "multipart/form-data"

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

media_id = JSON.parse(res.body)["id"]

# publicar status
uri = URI("#{instance}/api/v1/statuses")

req = Net::HTTP::Post.new(uri)
req["Authorization"] = "Bearer #{token}"

req.set_form_data({
  status: "Today in Ruby\n\nUpcoming Ruby events\n\n#Ruby #RubyKaigi",
  media_ids: [media_id]
})

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

puts res.body