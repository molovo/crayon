require "./spec_helper"

describe Crayon::Text do
  it "Outputs plain text" do
    crayon = Crayon::Text.new
    out    = crayon.render "testing"
    out.should eq("\033[0;mtesting\033[0;m")
  end

  it "Outputs black text" do
    crayon = Crayon::Text.new
    out    = crayon.black "testing"
    out.should eq("\033[0;30mtesting\033[0;m")
  end

  it "Outputs red text" do
    crayon = Crayon::Text.new
    out    = crayon.red "testing"
    out.should eq("\033[0;31mtesting\033[0;m")
  end

  it "Outputs green text" do
    crayon = Crayon::Text.new
    out    = crayon.green "testing"
    out.should eq("\033[0;32mtesting\033[0;m")
  end

  it "Outputs yellow text" do
    crayon = Crayon::Text.new
    out    = crayon.yellow "testing"
    out.should eq("\033[0;33mtesting\033[0;m")
  end

  it "Outputs blue text" do
    crayon = Crayon::Text.new
    out    = crayon.blue "testing"
    out.should eq("\033[0;34mtesting\033[0;m")
  end

  it "Outputs magenta text" do
    crayon = Crayon::Text.new
    out    = crayon.magenta "testing"
    out.should eq("\033[0;35mtesting\033[0;m")
  end

  it "Outputs cyan text" do
    crayon = Crayon::Text.new
    out    = crayon.cyan "testing"
    out.should eq("\033[0;36mtesting\033[0;m")
  end

  it "Outputs white text" do
    crayon = Crayon::Text.new
    out    = crayon.white "testing"
    out.should eq("\033[0;37mtesting\033[0;m")
  end

  it "Outputs text with black background" do
    crayon = Crayon::Text.new
    out    = crayon.blackbg "testing"
    out.should eq("\033[0;40mtesting\033[0;m")
  end

  it "Outputs text with red background" do
    crayon = Crayon::Text.new
    out    = crayon.redbg "testing"
    out.should eq("\033[0;41mtesting\033[0;m")
  end

  it "Outputs text with green background" do
    crayon = Crayon::Text.new
    out    = crayon.greenbg "testing"
    out.should eq("\033[0;42mtesting\033[0;m")
  end

  it "Outputs text with yellow background" do
    crayon = Crayon::Text.new
    out    = crayon.yellowbg "testing"
    out.should eq("\033[0;43mtesting\033[0;m")
  end

  it "Outputs text with blue background" do
    crayon = Crayon::Text.new
    out    = crayon.bluebg "testing"
    out.should eq("\033[0;44mtesting\033[0;m")
  end

  it "Outputs text with magenta background" do
    crayon = Crayon::Text.new
    out    = crayon.magentabg "testing"
    out.should eq("\033[0;45mtesting\033[0;m")
  end

  it "Outputs text with cyan background" do
    crayon = Crayon::Text.new
    out    = crayon.cyanbg "testing"
    out.should eq("\033[0;46mtesting\033[0;m")
  end

  it "Outputs text with white background" do
    crayon = Crayon::Text.new
    out    = crayon.whitebg "testing"
    out.should eq("\033[0;47mtesting\033[0;m")
  end

  it "Outputs bold text" do
    crayon = Crayon::Text.new
    out    = crayon.bold "testing"
    out.should eq("\033[1;mtesting\033[0;m")
  end

  it "Outputs italic text" do
    crayon = Crayon::Text.new
    out    = crayon.italic "testing"
    out.should eq("\033[2;mtesting\033[0;m")
  end

  it "Outputs underlined text" do
    crayon = Crayon::Text.new
    out    = crayon.underline "testing"
    out.should eq("\033[4;mtesting\033[0;m")
  end

  it "Outputs blinking text" do
    crayon = Crayon::Text.new
    out    = crayon.blink "testing"
    out.should eq("\033[5;mtesting\033[0;m")
  end

  it "Outputs inverted text" do
    crayon = Crayon::Text.new
    out    = crayon.inverse "testing"
    out.should eq("\033[7;mtesting\033[0;m")
  end

  it "Outputs deleted text" do
    crayon = Crayon::Text.new
    out    = crayon.strikethrough "testing"
    out.should eq("\033[9;mtesting\033[0;m")
  end

  it "Strips encoding" do
    crayon = Crayon::Text.new
    out = crayon.strip "\033[1;31mtesting\033[0;m"
    out.should eq("testing")
  end

  it "Repeats characters" do
    crayon = Crayon::Text.new
    out = crayon.repeat 'a', 10
    out.should eq("aaaaaaaaaa")
  end
end
