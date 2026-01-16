# close

```ruby
gif.close
```

Finalizes the animated GIF and completes file writing.

---

## Overview

`close` finishes the GIF encoding process by writing
the GIF trailer and closing the underlying file handle.

Calling this method ensures the animated GIF is valid
and properly formatted.

---

## Behavior

- Writes the GIF trailer
- Closes the output file handle
- Resets internal encoder state
- Prevents further frame additions

---

## Safety

- Calling `close` multiple times is safe
- No exception is raised if the GIF is already closed
- Safe to call even if no frames were added

---

## Notes

- Failing to call `close` may leave the GIF corrupted
- Always call `close` after the last `add_frame`

---

## Example

```ruby
gif = GD::Gif.new("animation.gif")

img = GD::Image.new(200, 200)
img.filled_circle(100, 100, 50, GD::Color.rgb(0, 128, 255))

gif.add_frame(img)
gif.close
```

---

## Related Methods

- [`GD::Gif.new`](new.md)
- [`add_frame`](add_frame.md)
