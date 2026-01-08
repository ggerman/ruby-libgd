require "spec_helper"

RSpec.describe GD::Image do
  it "clones image into a deep copy" do
    img = GD::Image.new(50,50)
    clone = img.clone

    expect(clone).to be_a(GD::Image)
    expect(clone.object_id).not_to eq(img.object_id)
    expect(clone.width).to eq(img.width)
    expect(clone.height).to eq(img.height)
  end

  it "fails if image is null" do
    img = GD::Image.allocate
    expect { img.clone }.to raise_error(RuntimeError)
  end
end
