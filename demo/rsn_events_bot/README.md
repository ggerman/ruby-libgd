# RubyStackNews Events Bot

RubyStackNews Events Bot generates a visual list of upcoming Ruby conferences and meetups.
It reads events from a YAML file and produces a clean image that can be shared on social networks or newsletters.

The goal is to make Ruby community events easy to discover and promote.

## Features

* Reads events from a simple YAML file
* Filters only upcoming events for the current year
* Displays a countdown until each event
* Uses visual indicators to highlight upcoming events
* Generates shareable images automatically
* Lightweight and script-friendly

## Countdown Indicators

Events are visually categorized depending on how soon they will occur.

| Icon | Meaning                               |
| ---- | ------------------------------------- |
| 🔥   | Event happening soon                  |
| ⏳    | Event approaching                     |
| 📅   | Event scheduled further in the future |

This makes the event list easy to scan quickly.

## Example Output

The bot produces an image similar to:

```
RubyStackNews — Upcoming Ruby Events

🔥 Ruby Community Conference Winter Edition → Kraków, Poland • 4 days
⏳ Rubysur → Buenos Aires, Argentina • 9 days
📅 RubyKaigi → Hakodate, Japan • 44 days
```

## Event Data Format

Events are defined in a YAML file.

Example:

```yaml
events:
  - name: Ruby Community Conference Winter Edition
    location: Kraków, Poland
    date: 2026-03-13

  - name: Rubysur
    location: Buenos Aires, Argentina
    date: 2026-03-18

  - name: RubyKaigi
    location: Hakodate, Japan
    date: 2026-05-20
```

## How It Works

1. Load events from the YAML file.
2. Parse event dates.
3. Filter events occurring in the current year.
4. Calculate remaining days.
5. Assign an icon depending on how soon the event occurs.
6. Render the list into an image.

## Running the Script

```
ruby generate_events_image.rb
```

The script will create an image with the current upcoming events.

## Contributing

If you know about a Ruby event that should appear here, feel free to contribute.

You can:

* open a pull request adding it to the YAML file
* or send the event information to:

**[ggerman@gmail.com](mailto:ggerman@gmail.com)**

## License

MIT
