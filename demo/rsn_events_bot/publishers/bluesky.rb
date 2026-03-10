require "atproto"

module Publishers
  class Bluesky
    def post(text, image_path)
      identifier = ENV["BSKY_USER"],
      password = ENV["BSKY_PASS"]

      return false unless identifier && password

      client = Atproto::Client.new

      client.login(
        identifier: identifier,
        password: password
      )

      client.create_post(text: text)
    end
  end
end