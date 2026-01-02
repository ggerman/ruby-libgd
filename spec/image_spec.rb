require "spec_helper"

RSpec.describe GD::Image do
  it "creates and saves a blank image" do
    img = GD::Image.new(100,100)
    img.save("#{TMP}/blank.png")

    expect(File.exist?("#{TMP}/blank.png")).to be true
  end
end

