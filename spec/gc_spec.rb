require "spec_helper"

RSpec.describe "GC safety" do
  it "does not crash under GC pressure" do
    200.times do
      img = GD::Image.new(50,50)
      img.filled_circle(10,10,5, GD::Color.rgb(255,0,0))
    end

    GC.start
  end
end
