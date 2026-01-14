# text_ft

FreeTypeEx を使用して高品質な TrueType / OpenType テキストを描画します。

`text_ft` は DPI、改行、行間、回転などの高度なタイポグラフィ機能を提供し、地図ラベルや印刷品質の画像に最適です。

## 構文

```ruby
image.text_ft(text, x:, y:, font:, size:, color:, angle: 0.0, dpi: 96, line_spacing: 1.0)
```

## パラメータ

| 名前 | 型 | 説明 |
|------|----|------|
| `text` | `String` | UTF-8 文字列 |
| `x` | `Integer` | ベースラインの X 座標 |
| `y` | `Integer` | ベースラインの Y 座標 |
| `font` | `String` | TrueType または OpenType フォントのパス |
| `size` | `Numeric` | フォントサイズ（ポイント） |
| `color` | `Array` | `[R, G, B]` または `[R, G, B, A]` |
| `angle` | `Float` | 回転角（ラジアン、デフォルト `0.0`） |
| `dpi` | `Integer` | 解像度（デフォルト `96`） |
| `line_spacing` | `Float` | 行間倍率（デフォルト `1.0`） |

## 例

```ruby
img.text_ft(
  "東京\n新宿",
  x: 100,
  y: 150,
  font: "NotoSans-Regular.ttf",
  size: 28,
  color: [255,255,255],
  dpi: 144,
  line_spacing: 1.4
)
```

## 回転

```ruby
img.text_ft(
  "国道 66 号線",
  x: 200,
  y: 200,
  font: "NotoSans-Bold.ttf",
  size: 24,
  color: [0,0,0],
  angle: Math::PI / 6
)
```

## 注記

- `text_ft` は内部で `gdImageStringFTEx` を使用します。
- DPI と行間は FreeType のレイアウトエンジンによって適用されます。
- 高解像度の地図、ポスター、ラベル描画に適しています。
