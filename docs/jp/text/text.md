# GD::Image#text（テキスト描画）

TrueType フォントを使用して画像に文字列を描画します。

## シグネチャ
```ruby
text(string, x:, y:, size:, color:, font:)
```

## パラメータ
- `string`: UTF-8 文字列
- `x`, `y`: ベースライン位置（`y` は上端ではなくベースライン）
- `size`: フォントサイズ（pt）
- `color`: `image.color` / `GD.rgba` で割り当てた色
- `font`: `.ttf` フォントへのパス

## 例
```ruby
img = GD::Image.new(400,200)
black = img.color(0,0,0)

img.text(
  "Hello Ruby",
  x: 20, y: 100,
  size: 24,
  color: black,
  font: "./fonts/DejaVuSans.ttf"
)

img.save("text.png")
```

## 補足
- libgd の FreeType レンダラを使用（アンチエイリアス + UTF-8）。
- 文字が切れる場合は `y`（ベースライン）や余白を調整してください。
