require_relative "publishers/mastodon"
require_relative "publishers/bluesky"
require_relative "publishers/discord"

message = "Ruby events this week 🧵\n🤖 Generated automatically by RubyEventsBot using ruby-libgd.
Updated every 7 days.\n#Ruby #RubyEvents #RubyLanguage #RubyOnRails"
image   = "demo/rsn_events_bot/rsn_events.png"

publishers = [
  Publishers::Mastodon.new,
  Publishers::Bluesky.new,
  Publishers::Discord.new
]

publishers.each do |publisher|
  puts publisher.post(message, image) ? "x" : "."
end

puts "Publishing finished"