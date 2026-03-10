require "net/http"
require "json"
require "time"

module Publishers
  class Bluesky
    def post(text, _image)
      user = ENV["BSKY_USER"]
      pass = ENV["BSKY_PASS"]

      return unless user && pass

      # -------------------------
      # login
      # -------------------------

      login_uri = URI("https://bsky.social/xrpc/com.atproto.server.createSession")

      login_body = {
        identifier: user,
        password: pass
      }

      login_res = http_post(login_uri, login_body, {
        "Content-Type" => "application/json"
      })

      return false unless login_res.code.to_i == 200

      session = JSON.parse(login_res.body)

      access_token = session["accessJwt"]
      did = session["did"]

      # -------------------------
      # create post
      # -------------------------

      post_uri = URI("https://bsky.social/xrpc/com.atproto.repo.createRecord")

      post_body = {
        repo: did,
        collection: "app.bsky.feed.post",
        record: {
          text: text,
          createdAt: Time.now.utc.iso8601
        }
      }

      post_res = http_post(post_uri, post_body, {
        "Authorization" => "Bearer #{access_token}",
        "Content-Type" => "application/json"
      })

      post_res.code.to_i == 200
    end

    private

    def http_post(uri, body, headers = {})
      req = Net::HTTP::Post.new(uri)

      headers.each { |k, v| req[k] = v }

      req.body = body.to_json

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      return res.code.to_i == 200
    end
  end
end