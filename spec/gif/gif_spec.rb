# frozen_string_literal: true

require "spec_helper"
require "fileutils"

RSpec.describe GD::Gif do
  let(:path) { File.join(TMP, "test.gif") }



  def build_image(color = [255, 0, 0])
    img = GD::Image.new(100, 100)

    c = GD::Color.rgb(*color)
    img.filled_rectangle(0, 0, 99, 99, c)

    img
  end

  it "creates a gif file on disk" do
    gif = described_class.new(path)
    gif.add_frame(build_image)
    gif.close

    expect(File.exist?(path)).to be(true)
    expect(File.size(path)).to be > 0
  end


  it "accepts loop option" do
    expect {
      gif = described_class.new(path, loop: true)
      gif.close
    }.not_to raise_error
  end

  it "adds frames" do
    gif = described_class.new(path)
    gif.add_frame(build_image([255, 0, 0]), delay: 10)
    gif.add_frame(build_image([0, 255, 0]), delay: 20)
    gif.add_frame(build_image([0, 0, 255]), delay: 30)
    gif.close

    expect(File.size(path)).to be > 0
  end

  it "is GC-safe across frames" do
    gif = described_class.new(path)

    5.times do |i|
      gif.add_frame(build_image([i * 40, 0, 0]))
    end

    GC.start
    gif.close

    expect(File.size(path)).to be > 0
  end

  it "writes a GIF89a header" do
    gif = described_class.new(path)
    gif.add_frame(build_image)
    gif.close

    header = File.binread(path, 6)
    expect(header).to eq("GIF89a")
  end
end

