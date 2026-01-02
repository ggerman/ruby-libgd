require "spec_helper"

RSpec.describe "Clone" do
  it "clones without sharing memory" do
    img = GD::Image.new(50,50)
    img.filled_circle(10,10,5, GD::Color.rgb(255,0,0))

    clone = img.clone
    clone.filled_circle(30,30,5, GD::Color.rgb(0,0,255))

    img.save("#{TMP}/a.png")
    clone.save("#{TMP}/b.png")

    expect(px("#{TMP}/a.png",30,30)).not_to eq(px("#{TMP}/b.png",30,30))
  end
end
