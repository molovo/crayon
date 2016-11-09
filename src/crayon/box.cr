module Crayon
  class Box
    enum Style : UInt8
      NoBorder
      Single
      Double
      Rounded
      SingleDouble
      DoubleSingle
      Classic
    end

    STYLES = [{
      :bottom_left  => "",
      :bottom_right => "",
      :horizontal   => "",
      :top_left     => "",
      :top_right    => "",
      :vertical     => "",
    }, {
      :bottom_left  => '└',
      :bottom_right => '┘',
      :horizontal   => '─',
      :top_left     => '┌',
      :top_right    => '┐',
      :vertical     => '│',
    }, {
      :bottom_left  => '╚',
      :bottom_right => '╝',
      :horizontal   => '═',
      :top_left     => '╔',
      :top_right    => '╗',
      :vertical     => '║',
    }, {
      :bottom_left  => '╰',
      :bottom_right => '╯',
      :horizontal   => '─',
      :top_left     => '╭',
      :top_right    => '╮',
      :vertical     => '│',
    }, {
      :bottom_left  => '╙',
      :bottom_right => '╜',
      :horizontal   => '─',
      :top_left     => '╓',
      :top_right    => '╖',
      :vertical     => '║',
    }, {
      :bottom_left  => '╘',
      :bottom_right => '╛',
      :horizontal   => '═',
      :top_left     => '╒',
      :top_right    => '╕',
      :vertical     => '│',
    }, {
      :bottom_left  => '+',
      :bottom_right => '+',
      :horizontal   => '-',
      :top_left     => '+',
      :top_right    => '+',
      :vertical     => '|',
    }]

    # The border color
    @border_color = Color::White

    # The border style
    @border_style = Style::Single

    # The external margin of the box
    @margin = {
      :x => 0,
      :y => 0,
    }

    # The internal padding of the box
    @padding = {
      :x => 0,
      :y => 0,
    }

    # The width of the box
    #
    # This is set to the length of the longest line of
    # content on initialisation
    @width = 0

    # An instance of Crayon::Text used for styling the box
    @renderer = Text.new

    # An optional title
    @title : String?

    # The content of the box
    @content : Array(String)

    # Create the box
    #
    # ```
    # box = Crayon::Box.new("Rainbows!")
    # puts box.render
    # # ┌─────────┐
    # # │Rainbows!│
    # # └─────────┘
    # ```
    def initialize(content : String | Array(String))
      @content = prepare_content content
    end

    # Return the rendered box as a string
    def render : String
      content = @content
      content = add_padding(content)
      content = add_border(content)
      content = add_margin(content)

      content.join "\n"
    end

    # Set the title of the box
    #
    # ```
    # box = Crayon::Box.new("I believe in unicorns!")
    # box.set_title("Title")
    # puts box.render
    # # ┌ Title ───────────────┐
    # # │I believe in unicorns!│
    # # └──────────────────────┘
    # ```
    def set_title(title : String) : self
      @title = title

      self
    end

    # Set the border color
    def set_border_color(color : Color) : self
      @border_color = color

      self
    end

    # Set the border style
    def set_border_style(style : Style) : self
      @border_style = style

      self
    end

    # Set the external margin of the box
    #
    # *x* is the number of empty lines above and below
    # *y* is the number of spaces to the left and right
    def set_margin(x : Int32, y : Int32) : self
      @margin = {
        :x => x,
        :y => y,
      }

      self
    end

    # Set the internal padding of the box
    #
    # *x* is the number of empty lines above and below
    # *y* is the number of spaces to the left and right
    def set_padding(x : Int32, y : Int32) : self
      @padding = {
        :x => x,
        :y => y,
      }

      self
    end

    # Prepare the content ready for rendering
    private def prepare_content(content : String | Array(String)) : Array(String)
      # Ensure the width is reset before starting
      @width = 0

      # If a string is passed for content, convert it into an array
      if content.is_a?(String)
        content = content.split("\n")
      end

      # Loop through each line of content
      content.each do |line|
        # Strip any ANSI escape codes, and get the string length
        len = @renderer.strip(line).size

        # If this is the longest line, set the width to its length
        if len > @width
          @width = len
        end
      end

      # Loop through each line again
      content.each_with_index do |line, i|
        # Strip any ANSI escape codes, and get the string length
        len = @renderer.strip(line).size

        # Pad the string with white space to the width of the box
        content[i] = line + @renderer.repeat(' ', (@width - len))
      end

      content
    end

    # Add padding around the content
    private def add_padding(content : Array(String)) : Array(String)
      # Create a line of whitespace to create vertical padding
      pad = @renderer.repeat ' ', @width

      # Add the line of whitespace to the content
      # once for each line of padding
      size = 0
      while size < @padding[:y]
        content.unshift pad
        content << pad
        size += 1
      end

      # Create a string of whitespace the width of our horizontal padding
      pad = @renderer.repeat ' ', @padding[:x]

      # Append and prepend the padding to each line of content
      content.each_with_index do |line, i|
        content[i] = "#{pad}#{line}#{pad}"
      end

      content
    end

    # Add a border around the box
    private def add_border(content : Array(String)) : Array(String)
      # Get the full width, including padding
      width = @width + (2 * @padding[:x])

      # Get the hash for the selected border style
      style = STYLES[@border_style.value]
      color = @border_color

      # Get and color the character used for the left and right sides
      side = @renderer.set_color color, style[:vertical]

      # Loop through each line of content, and add the sides to each end
      content.each_with_index do |line, i|
        content[i] = "#{side}#{line}#{side}"
      end

      # Create the top border
      char = style[:horizontal]

      # Check if a title is set
      if !@title.nil?
        # Add whitespace around the title, and embed it within the top border
        title = " #{@title} "
        top = title + @renderer.repeat(char, width - title.size)
      else
        # Create the top border without a title
        top = @renderer.repeat char, width
      end

      # Add the corners to each end of the line
      top = style[:top_left] + top + style[:top_right]
      top = @renderer.set_color(color).render(top)

      # Add the top border before the content
      content.unshift top

      # Create the bottom border
      bottom = @renderer.repeat style[:horizontal], width
      bottom = style[:bottom_left] + bottom + style[:bottom_right]
      bottom = @renderer.set_color(color).render(bottom)

      # Add the bottom border after the content
      content << bottom

      content
    end

    # Add margin around the box
    private def add_margin(content : Array(String)) : Array(String)
      # Incrementally add vertical margin above and below the box
      size = 0
      while size < @margin[:y]
        content.unshift ""
        content << ""
        size += 1
      end

      # Create a string of whitespace the width of our horizontal margin
      pad = @renderer.repeat ' ', @margin[:x]

      # Append and prepend the padding to each line of content
      content.each_with_index do |line, i|
        content[i] = "#{pad}#{line}#{pad}"
      end

      content
    end
  end
end
