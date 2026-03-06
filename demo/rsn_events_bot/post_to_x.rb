require "x"

image_url = "https://raw.githubusercontent.com/ggerman/ruby-libgd/feature/demo-bot-agenda/demo/rsn_events_bot/rsn_events.png"

client = X::Client.new(
  api_key: ENV["TWITTER_API_KEY"],
  api_key_secret: ENV["TWITTER_API_SECRET"],
  access_token: ENV["TWITTER_ACCESS_TOKEN"],
  access_token_secret: ENV["TWITTER_ACCESS_SECRET"]
)

tweet = <<~TEXT
Today in Ruby

Upcoming Ruby community events

#{image_url}

#Ruby #RubyKaigi
TEXT

response = client.post("tweets", { text: tweet })

puts "Tweet posted"
puts response