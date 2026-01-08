require "spec_helper"

RSpec.describe GD::Color do
  it "builds rgba array clamping alpha" do
    c = GD::Color.rgba(10,20,30,200)
    expect(c).to eq([10,20,30,127])
  end
end
