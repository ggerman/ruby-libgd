require "net/http"
require "json"

instance = ENV["MASTODON_INSTANCE"]
token    = ENV["MASTODON_TOKEN"]

image_path = "demo/rsn_events_bot/rsn_events.png"

abort "Image not found" unless File.exist?(image_path)

# ---- upload media ----

uri = URI("#{instance}/api/v2/media")

req = Net::HTTP::Post.new(uri)
req["Authorization"] = "Bearer #{token}"

form_data = [
  ["file", File.open(image_path)]
]

req.set_form form_data, "multipart/form-data"

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(req)
end

media = JSON.parse(res.body)

puts "Media upload response:"
puts media

media_id = media["id"]

# ---- create status ----

uri = URI("#{instance}/api/v1/statuses")

req = Net::HTTP::Post.new(uri)
req["Authorization"] = "Bearer #{token}"

req.set_form_data(
  "status" => "📅 Upcoming Ruby events in the community\n\nFrom local meetups to major conferences like RubyKaigi, here are some of the next Ruby gatherings around the world.\n\n🤖 This image is generated automatically by RubyEventsBot using ruby-libgd.\nEvery 7 days the bot publishes a snapshot of upcoming Ruby conferences and meetups.\n\nSource:\nhttps://github.com/ggerman/ruby-libgd\n\nShare:\nX → https://twitter.com/intent/tweet?url=https://ruby.social/@gsgermanok/116183832101126893\nLinkedIn → https://www.linkedin.com/sharing/share-offsite/?url=https://ruby.social/@gsgermanok/116183832101126893\n\nWhat Ruby event are you planning to attend this year?\n\n#Ruby #RubyOnRails #RubyCommunity",
  "media_ids[]" => media_id
)

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(req)
end

puts "Status response:"
puts res.body