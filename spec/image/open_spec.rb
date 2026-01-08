require "spec_helper"
require "tmpdir"

RSpec.describe GD::Image do
  let(:png) { File.join(__dir__, "..", "fixtures", "test.png") }

  it "loads a PNG image" do
    img = GD::Image.open(png)

    expect(img.width).to be > 0
    expect(img.height).to be > 0
  end

  it "raises Errno if file does not exist" do
    expect {
      GD::Image.open("foo.txt")
    }.to raise_error(Errno::ENOENT)
  end

  it "raises ArgumentError on unsupported format" do
    dir = Dir.mktmpdir
    path = File.join(dir, "bad.bmp")
    File.write(path, "not an image")

    expect {
      GD::Image.open(path)
    }.to raise_error(ArgumentError)
  end
end
