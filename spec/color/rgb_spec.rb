require "spec_helper"

RSpec.describe GD::Color do
  it "builds rgb array" do
    expect(GD::Color.rgb(1,2,3)).to eq([1,2,3])
  end
end
