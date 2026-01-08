require "spec_helper"

RSpec.describe GD::Image do
  it "sets alpha blending" do
    img = GD::Image.new(10,10)
    expect { img.alpha_blending = true }.not_to raise_error
    expect { img.save_alpha = true }.not_to raise_error
  end
end
