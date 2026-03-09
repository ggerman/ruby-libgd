require "gd"
require "yaml"
require "date"
require_relative "fonts"

require 'pry'

WIDTH  = 1200
HEIGHT = 630

FONT_SIZE_REGULAR = 18
FONT_SIZE_SMALL = 15
LINE_HEIGHT = 30

today = Date.today
today_str = today.strftime("%B %d, %Y")

events = YAML.safe_load(
  File.read(File.join(__dir__, "events.yml")),
  permitted_classes: [],
  aliases: false
)["events"]

# ---- filter events ----
events = events.select do |event|
  date = Date.parse(event["date"])
  days = (date - today).to_i
  days >= 0 && days < 100
end

events.sort_by! { |e| Date.parse(e["date"]) }

# ---- image ----
img = GD::Image.new(WIDTH, HEIGHT)

bg = GD::Color.rgb(251, 247, 242)
black = GD::Color.rgba(10, 10, 10, 50)
yellow = GD::Color.rgb(181, 137, 0)
blue = GD::Color.rgb(38, 139, 210)
gray = GD::Color.rgb(140,140,140)
ruby  = GD::Color.rgb(200, 0, 0)

img.fill(bg)
font = GD::Fonts.random
# ---- logo ----
logo = GD::Image.open(File.join(__dir__, "logotype-light.png"))
img.copy(logo, 40, 20, 0, 0, logo.width, logo.height)

# ---- date ----
img.text(today_str, x: WIDTH - 220, y: 60, font: font, size: FONT_SIZE_REGULAR, color: black)

# ---- events layout ----
start_y = 90
bottom_margin = 40
line_height = LINE_HEIGHT
y = start_y

events.each do |event|
  date = Date.parse(event["date"])
  days = (date - today).to_i
  text = "#{event["name"]} → #{event["location"]} • #{days} days"
  days = (date - today).to_i

  icon_path =
    if days <= 10
      "assets/fire.png"
    elsif days < 30
      "assets/hourglass.png"
    else
      "assets/calendar.png"
    end
  
  icon = GD::Image.open(File.join(__dir__, icon_path))
  img.copy(icon, 40, y - 18, 0, 0, icon.width, icon.height)
  img.text_ft(text, x: 80, y: y, font: font, size: FONT_SIZE_SMALL, color: (days <= 10) ? yellow : blue)

  img.line(30, y + 6, WIDTH - 30, y + 6, black)
  y += line_height
end

# ---- signature ----
img.text("gags", x: WIDTH - 80, y: HEIGHT - 20, font: font, size: 20, color: ruby)
footer = "Want to add your Ruby event? Send it to ggerman@gmail.com"
img.text(footer, x: 30, y: HEIGHT - 10, font: font, size: 10, color: black)
img.save(File.join(__dir__, "rsn_events.png"))

puts "Generated rsn_events.png"
