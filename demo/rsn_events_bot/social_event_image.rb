require "gd"
require "yaml"
require "date"
require_relative "fonts"

WIDTH  = 800
HEIGHT = 630

today = Date.today
today_str = today.strftime("%Y-%m-%d")

events = YAML.safe_load(
  File.read(File.join(__dir__, "events.yml")),
  permitted_classes: [],
  aliases: false
)["events"]

# ---- filter events ----

events = events.select do |event|
  date = Date.parse(event["date"])
  days = (date - today).to_i
  days >= 0 && date.year == today.year
end

events.sort_by! { |e| Date.parse(e["date"]) }

# ---- image ----

img = GD::Image.new_true_color(WIDTH, HEIGHT)

bg = GD::Color.rgb(251, 247, 242)
black = GD::Color.rgba(10, 10, 10, 50)
ruby  = GD::Color.rgb(200, 0, 0)

img.fill(bg)

font = GD::Fonts.find("FreeSans") || GD::Fonts.random

# ---- logo ----

logo = GD::Image.open(File.join(__dir__, "logotype-light.png"))

img.copy(
  logo,
  40,
  20,
  0,
  0,
  logo.width,
  logo.height
)

# ---- date ----

img.text(
  today_str,
  x: WIDTH - 160,
  y: 60,
  font: font,
  size: 15,
  color: black
)

# ---- events layout ----

start_y = 140
bottom_margin = 40
available_height = HEIGHT - start_y - bottom_margin

event_count = events.size
event_count = 1 if event_count == 0

line_height = available_height / event_count

line_height = 25 if line_height > 25

y = start_y

events.each do |event|

  date = Date.parse(event["date"])
  days = (date - today).to_i

  text = "#{event["name"]} — #{event["location"]} — #{days}d"

  img.text(
    text,
    x: 60,
    y: y,
    font: font,
    size: 12,
    color: black
  )

  y += line_height
end

# ---- signature ----

img.text(
  "gags",
  x: WIDTH - 80,
  y: HEIGHT - 20,
  font: font,
  size: 20,
  color: ruby
)

img.save(File.join(__dir__, "rsn_events.png"))

puts "Generated rsn_events.png"
