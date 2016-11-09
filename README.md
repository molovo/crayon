# crayon

A collection of helpers for building pretty command-line tools in [Crystal](http://crystal-lang.org).

```crystal
require "crayon"

crayon = Crayon::Text.new
puts crayon.bold.yellow("I believe in unicorns!")
# => "\033[1;33mI believe in unicorns!\033[0;m"
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crayon:
    github: molovo/crayon
```

## Usage

Once instantiated, the Graphite class becomes a re-usable string rendering tool. It comes with a number of methods for styling the foreground color, background color and style of a string using ANSI escape codes.

```crystal
puts crayon.red("This is a red string")
# => "\033[0;31mThis is a red string\033[0;m"
```

When color methods are accessed without arguments, these methods allow chaining of styles. When a string is passed as the first argument, it is returned with all the chained styles applied.

```crystal
puts crayon.red.yellowbg().underline("A string")
# => "\033[4;31;43mA string\033[0;m"
```

### Available styling methods

* `black`
* `blackbg`
* `red`
* `redbg`
* `green`
* `greenbg`
* `yellow`
* `yellowbg`
* `blue`
* `bluebg`
* `magenta`
* `magentabg`
* `cyan`
* `cyanbg`
* `white`
* `whitebg`
* `bold`
* `italic`
* `underline`
* `blink`
* `inverse`
* `strikethrough`

### Additional Methods

As well as the styling methods above, the following helper methods are available.

#### `strip(str : String) : String`

The `strip` method strips all ANSI escape codes from the passed string and returns it.

```crystal
str = "\033[0;31mA string with ANSI escaping\033[0;m"
puts crayon.strip(str)
# => "A string with ANSI escaping"
```

#### `repeat(char : Char, length : Int32) : String`

The `repeat` method returns a string consisting of the defined *`char`*, repeated *`length`* times.

```crystal
puts crayon.repeat('+', 5)
# => "+++++"
```

### Boxes

The `Crayon::Box` class adds a border around a string (or an array of strings, where each item is a line).

```crystal
box = Crayon::Box.new("Rainbows!")
puts box.render
# ┌─────────┐
# │Rainbows!│
# └─────────┘
```

Boxes can be styled in a number of ways.

```crystal
box = Crayon::Box.new("Unicorns!")
box.set_border_color Crayon::Color::White,        # The color of the border (and title)
box.set_border_style Crayon::Box::Style::Single,  # The border style
box.set_margin 0, 0                               # The horizontal and vertical margin
box.set_padding 0, 0                               # The horizontal and vertical padding
```

The following styles are available:

```
Crayon::Box::Style::Single
┌──────────┐
│The string│
└──────────┘

Crayon::Box::Style::Double
╔══════════╗
║The string║
╚══════════╝

Crayon::Box::Style::Rounded
╭──────────╮
│The string│
╰──────────╯

Crayon::Box::Style::SingleDouble
╓──────────╖
║The string║
╙──────────╜

Crayon::Box::Style::DoubleSingle
╒══════════╕
│The string│
╘══════════╛

Crayon::Box::Style::Classic
+----------+
|The string|
+----------+
```

You can also use the constant `Crayon::Box::Style::NoBorder` to add margin and padding to a string without a border.

```crystal
box = Crayon::Box.new("Unicorns and\nrainbows")
box.set_border_style Crayon::Box::Style::NoBorder
box.set_padding 2, 1
puts box.render
#
#   Unicorns and
#   rainbows
#
```

You can also add titles to boxes. These are rendered within the border, in the same color.

```php
box = Crayon::Box.new("The string")
box.set_padding 1, 0
box.set_title "My Box"
puts box.render
# ┌ My Box ────┐
# │ The string │
# └────────────┘
```

## TODO

- Finish writing specs for `Color::Box`
- Add table renderer

## Contributing

1. [Fork it](https://github.com/molovo/crayon/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [molovo](https://github.com/molovo) James Dinsdale - creator, maintainer

## Related

- [Graphite](https://github.com/molovo/graphite) The PHP package that this library was ported from.
