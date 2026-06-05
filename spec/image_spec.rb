require "spec_helper"

RSpec.describe GD::Image do
  # ─────────────────────────────────────────────────────────────
  # initialize
  # ─────────────────────────────────────────────────────────────

  describe ".new" do
    context "with no arguments" do
      it "raises ArgumentError" do
        expect { GD::Image.new }.to raise_error(ArgumentError, /width and height are required/)
      end
    end

    context "with a single argument" do
      it "raises ArgumentError" do
        expect { GD::Image.new(100) }.to raise_error(ArgumentError, /expected 0 or 2 arguments/)
      end
    end

    context "with valid dimensions" do
      it "creates the image without error" do
        expect { GD::Image.new(100, 100) }.not_to raise_error
      end
    end

    context "with dimensions <= 0" do
      it "raises ArgumentError when width is 0" do
        expect { GD::Image.new(0, 100) }.to raise_error(ArgumentError, /must be positive/)
      end

      it "raises ArgumentError when height is negative" do
        expect { GD::Image.new(100, -1) }.to raise_error(ArgumentError, /must be positive/)
      end
    end
  end

  # ─────────────────────────────────────────────────────────────
  # NULL guard on instance methods
  # ─────────────────────────────────────────────────────────────

  describe "methods on an uninitialized image" do
    let(:img) { GD::Image.allocate }  # wrap->img = NULL

    it "#width raises RuntimeError" do
      expect { img.width }.to raise_error(RuntimeError, /not initialized/)
    end

    it "#height raises RuntimeError" do
      expect { img.height }.to raise_error(RuntimeError, /not initialized/)
    end

    it "#alpha_blending= raises RuntimeError" do
      expect { img.alpha_blending = true }.to raise_error(RuntimeError, /not initialized/)
    end

    it "#save_alpha= raises RuntimeError" do
      expect { img.save_alpha = true }.to raise_error(RuntimeError, /not initialized/)
    end

    it "#antialias= raises RuntimeError" do
      expect { img.antialias = true }.to raise_error(RuntimeError, /not initialized/)
    end
  end
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
      red = [255, 0, 0, 0]
      src.filled_rectangle(0, 0, 49, 49, red)

      # Copy into destination at (10,10)
      dst.copy(src, 10, 10, 0, 0, 50, 50)

      # Pick a pixel inside the copied region
      pixel = dst.get_pixel(20, 20)

      expect(pixel).to eq(red)
    end

    it "does not affect pixels outside the copied region" do
      src = GD::Image.new(20, 20)
      dst = GD::Image.new(40, 40)

      green = [0, 255, 0, 0]
      blue  = [0, 0, 255, 0]

      src.filled_rectangle(0, 0, 19, 19, green)
      dst.filled_rectangle(0, 0, 39, 39, blue)

      dst.copy(src, 10, 10, 0, 0, 20, 20)

      expect(dst.get_pixel(5, 5)).to eq(blue)
      expect(dst.get_pixel(15, 15)).to eq(green)
    end
  end

end

