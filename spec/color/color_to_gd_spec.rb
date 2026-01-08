# spec/color/color_to_gd_spec.rb
RSpec.describe "GD color arrays" do
  it "accepts rgb arrays" do
    expect(GD::Color.rgb(1,2,3)).to eq([1,2,3])
  end

  it "accepts rgba arrays" do
    expect(GD::Color.rgba(1,2,3,4).size).to eq(4)
  end
end
