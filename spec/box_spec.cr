require "./spec_helper.cr"

describe Crayon::Box do
  it "Should render with defaults" do
    box = Crayon::Box.new("Rainbows!")
    out = box.render

    out.should eq("\e[0;37m┌─────────┐\e[0;m\n\e[0;37m│\e[0;mRainbows!\e[0;37m│\e[0;m\n\e[0;37m└─────────┘\e[0;m")
  end
end
