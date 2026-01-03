require "spec_helper"

RSpec.describe GD::Image do
  it "creates and saves a blank image" do
    img = GD::Image.new(100,100)
    img.save("#{TMP}/blank.png")

    expect(File.exist?("#{TMP}/blank.png")).to be true
  end

  describe "#copy" do
    it "copies a region from a source image into the destination image" do
      src = GD::Image.new(50, 50)
      dst = GD::Image.new(100, 100)

      # Fill source with red
      red = [255, 0, 0]
      src.filled_rect(0, 0, 49, 49, red)

      # Copy into destination at (10,10)
      dst.copy(src, 10, 10, 0, 0, 50, 50)

      # Pick a pixel inside the copied region
      pixel = dst.get_pixel(20, 20)

      expect(pixel).to eq(red)
    end

    it "does not affect pixels outside the copied region" do
      src = GD::Image.new(20, 20)
      dst = GD::Image.new(40, 40)

      green = [0, 255, 0]
      blue  = [0, 0, 255]

      src.filled_rect(0, 0, 19, 19, green)
      dst.filled_rect(0, 0, 39, 39, blue)

      dst.copy(src, 10, 10, 0, 0, 20, 20)

      expect(dst.get_pixel(5, 5)).to eq(blue)
      expect(dst.get_pixel(15, 15)).to eq(green)
    end
  end

end

