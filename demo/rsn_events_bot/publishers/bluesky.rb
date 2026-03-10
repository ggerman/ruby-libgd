require "net/http"
require "json"
require "time"

BSKY_USER = ENV["BSKY_USER"]
BSKY_PASS = ENV["BSKY_PASS"]

exit unless BSKY_USER && BSKY_PASS

TEXT = <<~TEXT
📅 Upcoming Ruby events around the world

From local meetups to conferences like RubyKaigi, here are some of the next Ruby gatherings in the community.

🤖 Generated automatically using ruby-libgd.

Source:
https://github.com/ggerman/ruby-libgd

#Ruby #RubyOnRails #RubyCommunity
TEXT


def http_post(uri, body, headers = {})
  req = Net::HTTP::Post.new(uri)

  headers.each { |k, v| req[k] = v }

  req.body = body.to_json

  Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end
end


# -------------------------
# login
# -------------------------

login_uri = URI("https://bsky.social/xrpc/com.atproto.server.createSession")

login_body = {
  identifier: BSKY_USER,
  password: BSKY_PASS
}

login_headers = {
  "Content-Type" => "application/json"
}

login_res = http_post(login_uri, login_body, login_headers)

abort "Login failed: #{login_res.body}" unless login_res.code.to_i == 200

session = JSON.parse(login_res.body)

access_token = session["accessJwt"]
did = session["did"]

puts "Logged in as #{did}"

# -------------------------
# create post
# -------------------------

post_uri = URI("https://bsky.social/xrpc/com.atproto.repo.createRecord")

post_body = {
  repo: did,
  collection: "app.bsky.feed.post",
  record: {
    text: TEXT,
    createdAt: Time.now.utc.iso8601
  }
}

post_headers = {
  "Authorization" => "Bearer #{access_token}",
  "Content-Type" => "application/json"
}

post_res = http_post(post_uri, post_body, post_headers)

puts "Post response:"
puts post_res.body