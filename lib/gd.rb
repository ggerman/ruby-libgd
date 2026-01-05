require "gd/gd"

class GD::Image
  DEFAULT_FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
  DEFAULT_FONT_SIZE = 12

  def draw_string(x, y, text, color, size: DEFAULT_FONT_SIZE, font: DEFAULT_FONT)
    self.text(text, {
      x: x,
      y: y,
      size: size,
      color: color,
      font: font
    })
  end
end
