require "spec_helper"

RSpec.describe "Filters" do
  it "converts image to grayscale" do
    img = GD::Image.new(10,10)
    img.filled_rectangle(0,0,10,10, GD::Color.rgb(100,50,200))
    img.filter(:grayscale)
    img.save("#{TMP}/gray.png")

    r,g,b = rgb(px("#{TMP}/gray.png", 5,5))
    expect(r).to eq(g)
    expect(g).to eq(b)
  end
end
