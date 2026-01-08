require "spec_helper"

RSpec.describe GD::Image do
  it "creates a truecolor image via factory" do
    img = GD::Image.new_true_color(64, 32)

    expect(img.width).to eq(64)
    expect(img.height).to eq(32)
  end
end
