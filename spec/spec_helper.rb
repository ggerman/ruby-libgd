require "bundler/setup"
require "gd"

RSpec.configure do |config|
  config.order = :random
end

require_relative "support/image_helpers"
require_relative "support/tmp_helper"
