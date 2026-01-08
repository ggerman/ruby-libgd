require "spec_helper"

RSpec.describe GD::Image do
  it "copies pixels from one image to another" do
    src = GD::Image.new(20,20)
    dst = GD::Image.new(50,50)

    expect {
      dst.copy(src, 0,0, 0,0, 10,10)
    }.not_to raise_error
  end

  it "resizes and copies using resample" do
    src = GD::Image.new(20,20)
    dst = GD::Image.new(100,100)

    expect {
      dst.copy_resize(src, 0,0, 0,0, 20,20, 80,80, true)
    }.not_to raise_error
  end
end
