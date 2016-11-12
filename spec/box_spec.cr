require "./spec_helper.cr"

describe Crayon::Box do
  it "should render with single line string content" do
    box = Crayon::Box.new("Rainbows!")
    out = box.render

    out.should eq("\e[0;37m┌─────────┐\e[0;m\n\e[0;37m│\e[0;mRainbows!\e[0;37m│\e[0;m\n\e[0;37m└─────────┘\e[0;m")
  end

  it "should render with multiline string content" do
    box = Crayon::Box.new("Rainbows!\nAnd unicorns!")
    out = box.render

    out.should eq("\e[0;37m┌─────────────┐\e[0;m\n\e[0;37m│\e[0;mRainbows!    \e[0;37m│\e[0;m\n\e[0;37m│\e[0;mAnd unicorns!\e[0;37m│\e[0;m\n\e[0;37m└─────────────┘\e[0;m")
  end

  it "should render with array content" do
    box = Crayon::Box.new([
      "Rainbows!",
      "And unicorns!",
    ])
    out = box.render

    out.should eq("\e[0;37m┌─────────────┐\e[0;m\n\e[0;37m│\e[0;mRainbows!    \e[0;37m│\e[0;m\n\e[0;37m│\e[0;mAnd unicorns!\e[0;37m│\e[0;m\n\e[0;37m└─────────────┘\e[0;m")
  end

  it "should render with title" do
    box = Crayon::Box.new("Rainbows!")
    box.set_title "Title"
    out = box.render

    out.should eq("\e[0;37m┌ Title ──┐\e[0;m\n\e[0;37m│\e[0;mRainbows!\e[0;37m│\e[0;m\n\e[0;37m└─────────┘\e[0;m")
  end

  it "should add padding" do
    box = Crayon::Box.new("Rainbows!")
    box.set_padding 1, 1
    out = box.render

    out.should eq("\e[0;37m┌───────────┐\e[0;m\n\e[0;37m│\e[0;m           \e[0;37m│\e[0;m\n\e[0;37m│\e[0;m Rainbows! \e[0;37m│\e[0;m\n\e[0;37m│\e[0;m           \e[0;37m│\e[0;m\n\e[0;37m└───────────┘\e[0;m")
  end

  it "should add margin" do
    box = Crayon::Box.new("Rainbows!")
    box.set_margin 1, 1
    out = box.render

    out.should eq("  \n \e[0;37m┌─────────┐\e[0;m \n \e[0;37m│\e[0;mRainbows!\e[0;37m│\e[0;m \n \e[0;37m└─────────┘\e[0;m \n  ")
  end

  it "should render with border color" do
    box = Crayon::Box.new("Rainbows!")
    box.set_border_color Crayon::Color::Red
    out = box.render

    out.should eq("\e[0;31m┌─────────┐\e[0;m\n\e[0;31m│\e[0;mRainbows!\e[0;31m│\e[0;m\n\e[0;31m└─────────┘\e[0;m")
  end

  it "should render with double border" do
    box = Crayon::Box.new("Rainbows!")
    box.set_border_style Crayon::Box::Style::Double
    out = box.render

    out.should eq("\e[0;37m╔═════════╗\e[0;m\n\e[0;37m║\e[0;mRainbows!\e[0;37m║\e[0;m\n\e[0;37m╚═════════╝\e[0;m")
  end

  it "should render with rouded border" do
    box = Crayon::Box.new("Rainbows!")
    box.set_border_style Crayon::Box::Style::Rounded
    out = box.render

    out.should eq("\e[0;37m╭─────────╮\e[0;m\n\e[0;37m│\e[0;mRainbows!\e[0;37m│\e[0;m\n\e[0;37m╰─────────╯\e[0;m")
  end

  it "should render with single-double border" do
    box = Crayon::Box.new("Rainbows!")
    box.set_border_style Crayon::Box::Style::SingleDouble
    out = box.render

    out.should eq("\e[0;37m╓─────────╖\e[0;m\n\e[0;37m║\e[0;mRainbows!\e[0;37m║\e[0;m\n\e[0;37m╙─────────╜\e[0;m")
  end

  it "should render with double-single border" do
    box = Crayon::Box.new("Rainbows!")
    box.set_border_style Crayon::Box::Style::DoubleSingle
    out = box.render

    out.should eq("\e[0;37m╒═════════╕\e[0;m\n\e[0;37m│\e[0;mRainbows!\e[0;37m│\e[0;m\n\e[0;37m╘═════════╛\e[0;m")
  end

  it "should render with classic border" do
    box = Crayon::Box.new("Rainbows!")
    box.set_border_style Crayon::Box::Style::Classic
    out = box.render

    out.should eq("\e[0;37m+---------+\e[0;m\n\e[0;37m|\e[0;mRainbows!\e[0;37m|\e[0;m\n\e[0;37m+---------+\e[0;m")
  end
end
