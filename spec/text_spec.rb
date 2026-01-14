require "spec_helper"
require "gd"

RSpec.describe GD::Image, "text rendering" do
  let(:font) { GD::Fonts.find("noto") || GD::Fonts.random }

  let(:font) { File.expand_path("fixtures/fonts/Testing.ttf", __dir__) }

  def new_img
    GD::Image.new(400, 300)
  end

  it "renders basic .text without crashing" do
    img = new_img

    expect {
      img.text(
        "Hello",
        x: 20,
        y: 50,
        size: 20,
        color: [255,0,0],
        font: font
      )
    }.not_to raise_error
  end

  it "returns a valid bounding box" do
    img = new_img

    w, h = img.text_bbox(
      "Hello",
      font: font,
      size: 32
    )

    expect(w).to be > 0
    expect(h).to be > 0
    expect(w).to be > h / 2
  end

  it "bbox changes with size" do
    img = new_img

    w1, h1 = img.text_bbox("Test", font: font, size: 20)
    w2, h2 = img.text_bbox("Test", font: font, size: 40)

    expect(w2).to be > w1
    expect(h2).to be > h1
  end

  it "bbox changes with rotation" do
    img = new_img

    w1, h1 = img.text_bbox("Rotate", font: font, size: 32, angle: 0)
    w2, h2 = img.text_bbox("Rotate", font: font, size: 32, angle: Math::PI/4)

    expect(w2).not_to eq(w1)
    expect(h2).not_to eq(h1)
  end

  it "renders text_ft with DPI and line spacing" do
    img = new_img

    expect {
      img.text_ft(
        "Line 1\nLine 2",
        x: 20,
        y: 100,
        font: font,
        size: 24,
        color: [0,0,0],
        dpi: 144,
        line_spacing: 1.5
      )
    }.not_to raise_error
  end
end
