require "spec_helper"

RSpec.describe "Drawing" do
  it "draws a filled circle" do
    img = GD::Image.new(100,100)
    img.filled_circle(50,50,30, GD::Color.rgb(255,0,0))
    img.save("#{TMP}/circle.png")

    expect(px("#{TMP}/circle.png", 50,50)).not_to eq(0)
  end
end
