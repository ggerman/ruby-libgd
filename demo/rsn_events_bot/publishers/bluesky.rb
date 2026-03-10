require "atproto"

module Publishers
  class Bluesky
    def post(text, image_path)
      client = Atproto::Client.new

      client.login(
        identifier: ENV["BSKY_USER"],
        password: ENV["BSKY_PASS"]
      )

      client.create_post(text: text)
    end
  end
end