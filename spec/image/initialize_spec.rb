require "spec_helper"

RSpec.describe GD::Image do
  describe "#initialize" do
    it "creates a truecolor image with width and height" do
      img = GD::Image.new(100, 50)

      expect(img.width).to eq(100)
      expect(img.height).to eq(50)
    end

    it "rejects zero or negative sizes" do
      expect { GD::Image.new(0, 10) }.to raise_error(ArgumentError)
      expect { GD::Image.new(-1, 10) }.to raise_error(ArgumentError)
    end

    it "allows empty initialize" do
      img = GD::Image.allocate
      expect { img.send(:initialize) }.not_to raise_error
    end
  end
end
