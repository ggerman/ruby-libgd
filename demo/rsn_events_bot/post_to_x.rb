require "x"

client = X::Client.new(
  api_key: ENV["TWITTER_API_KEY"],
  api_key_secret: ENV["TWITTER_API_SECRET"],
  access_token: ENV["TWITTER_ACCESS_TOKEN"],
  access_token_secret: ENV["TWITTER_ACCESS_SECRET"]
)

media = client.post(
  "media/upload",
  media: File.open("rsn_events.png")
)

client.post(
  "tweets",
  text: "Upcoming Ruby events from RubyStackNews",
  media: { media_ids: [media["media_id_string"]] }
)