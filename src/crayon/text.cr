module Crayon
  class Text
    # ANSI escape codes for the start of the string
    ANSI_START = "\033[%s%s%sm"

    # ANSI escape codes for the end of the string
    ANSI_END = "\033[0;m"

    # The current text color
    @color : Color?

    # The current background color
    @bg_color : Color?

    # The current text style
    @style = Style::Normal

    # Render a string with ANSI escape codes added
    def render(str : String | Char) : String
      out = "#{encode(str)}"
      @color = nil
      @bg_color = nil
      @style = Style::Normal

      out
    end

    # Add ANSI escape codes to a string
    def encode(str : String | Char) : String
      "#{start}#{str}#{end}"
    end

    # Set the current color
    #
    # If a string is passed as a second argument, it is encoded
    # with the color applied and returned
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.set_color(Color::Black, "string")
    # # => "\033[0;30mstring\033[0;m"
    # ```
    #
    # If no second argument is passed, the instance is returned,
    # allowing methods to be chained
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.set_color(Color::Black).set_bg_color(Color::Red, "string")
    # # => "\033[0;41;30mstring\033[0;m"
    # ```
    def set_color(color : Color, str : String | Char? = nil) : self | String
      @color = color

      if !str.nil?
        return render str
      end

      self
    end

    # Set the current background color
    #
    # If a string is passed as a second argument, it is encoded
    # with the color applied and returned
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.set_bg_color(Color::Black, "string")
    # # => "\033[0;40mstring\033[0;m"
    # ```
    #
    # If no second argument is passed, the instance is returned,
    # allowing methods to be chained
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.set_bg_color(Color::Black).set_color(Color::Red, "string")
    # # => "\033[0;40;31mstring\033[0;m"
    # ```
    def set_bg_color(color : Color, str : String | Char? = nil) : self | String
      @bg_color = color

      if !str.nil?
        return render str
      end

      self
    end

    # Set the current style
    #
    # If a string is passed as a second argument, it is encoded
    # with the color applied and returned
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.set_style(Style::Bold, "string")
    # # => "\033[1;mstring\033[0;m"
    # ```
    #
    # If no second argument is passed, the instance is returned,
    # allowing methods to be chained
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.set_style(Style::Bold).set_color(Color::Red, "string")
    # # => "\033[0;41;30mstring\033[0;m"
    # ```
    def set_style(style : Style, str : String | Char? = nil) : self | String
      @style = style

      if !str.nil?
        return render str
      end

      self
    end

    # Alias of `#set_color(Color::Black, str)`
    def black(str : String | Char? = nil) : self | String
      set_color Color::Black, str
    end

    # Alias of `#set_color(Color::Red, str)`
    def red(str : String | Char? = nil) : self | String
      set_color Color::Red, str
    end

    # Alias of `#set_color(Color::Green, str)`
    def green(str : String | Char? = nil) : self | String
      set_color Color::Green, str
    end

    # Alias of `#set_color(Color::Yellow, str)`
    def yellow(str : String | Char? = nil) : self | String
      set_color Color::Yellow, str
    end

    # Alias of `#set_color(Color::Blue, str)`
    def blue(str : String | Char? = nil) : self | String
      set_color Color::Blue, str
    end

    # Alias of `#set_color(Color::Magenta, str)`
    def magenta(str : String | Char? = nil) : self | String
      set_color Color::Magenta, str
    end

    # Alias of `#set_color(Color::Cyan, str)`
    def cyan(str : String | Char? = nil) : self | String
      set_color Color::Cyan, str
    end

    # Alias of `#set_color(Color::White, str)`
    def white(str : String | Char? = nil) : self | String
      set_color Color::White, str
    end

    # Alias of `#set_bg_color(Color::Black, str)`
    def blackbg(str : String | Char? = nil) : self | String
      set_bg_color Color::Black, str
    end

    # Alias of `#set_bg_color(Color::Red, str)`
    def redbg(str : String | Char? = nil) : self | String
      set_bg_color Color::Red, str
    end

    # Alias of `#set_bg_color(Color::Green, str)`
    def greenbg(str : String | Char? = nil) : self | String
      set_bg_color Color::Green, str
    end

    # Alias of `#set_bg_color(Color::Yellow, str)`
    def yellowbg(str : String | Char? = nil) : self | String
      set_bg_color Color::Yellow, str
    end

    # Alias of `#set_bg_color(Color::Blue, str)`
    def bluebg(str : String | Char? = nil) : self | String
      set_bg_color Color::Blue, str
    end

    # Alias of `#set_bg_color(Color::Magenta, str)`
    def magentabg(str : String | Char? = nil) : self | String
      set_bg_color Color::Magenta, str
    end

    # Alias of `#set_bg_color(Color::Cyan, str)`
    def cyanbg(str : String | Char? = nil) : self | String
      set_bg_color Color::Cyan, str
    end

    # Alias of `#set_bg_color(Color::White, str)`
    def whitebg(str : String | Char? = nil) : self | String
      set_bg_color Color::White, str
    end

    # Alias of `#set_style(Style::Bold, str)`
    def bold(str : String | Char? = nil) : self | String
      set_style Style::Bold, str
    end

    # Alias of `#set_style(Style::Italic, str)`
    def italic(str : String | Char? = nil) : self | String
      set_style Style::Italic, str
    end

    # Alias of `#set_style(Style::Underline, str)`
    def underline(str : String | Char? = nil) : self | String
      set_style Style::Underline, str
    end

    # Alias of `#set_style(Style::Blink, str)`
    def blink(str : String | Char? = nil) : self | String
      set_style Style::Blink, str
    end

    # Alias of `#set_style(Style::Inverse, str)`
    def inverse(str : String | Char? = nil) : self | String
      set_style Style::Inverse, str
    end

    # Alias of `#set_style(Style::Strikethrough, str)`
    def strikethrough(str : String | Char? = nil) : self | String
      set_style Style::Strikethrough, str
    end

    # Strip ANSI encoding from a string
    #
    # ```
    # crayon = Crayon::Text.new
    # str    = "\033[0;33mA styled string\033[0;m"
    # puts crayon.strip "str"
    # => "A styled string"
    # ```
    def strip(str : String | Char) : String
      str.gsub /\033\[\d;(\d*;?)*m/, ""
    end

    # Create a string by repeating the *char* character *len* times
    #
    # ```
    # crayon = Crayon::Text.new
    # puts crayon.repeat('a', 10)
    # => "aaaaaaaaaa"
    # ```
    def repeat(char : Char | String, len : Int32) : String
      str = ""
      size = 0

      while (size += 1) <= len
        str += char
      end

      str
    end

    # Output the opening portion of the ANSI escape code
    #
    # Uses `ANSI_START` as a template to pass to sprintf
    private def start : String
      color = nil
      the_color = @color
      if the_color.responds_to?(:value)
        color = ";3#{the_color.value}"
      end

      bg_color = nil
      the_bg_color = @bg_color
      if the_bg_color.responds_to?(:value)
        bg_color = ";4#{the_bg_color.value}"
      end

      style = @style.value
      if @color.nil? && @bg_color.nil?
        style = "#{@style.value};"
      end

      ANSI_START % [style, color, bg_color]
    end

    # Output the closing portion of the ANSI escape code
    private def end : String
      ANSI_END
    end
  end
end
