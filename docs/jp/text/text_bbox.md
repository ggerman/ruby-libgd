# text_bbox

FreeType を使用して TrueType 文字列の描画サイズ（ピクセル単位）を取得します。

`text_bbox` は、実際の描画と同じ FreeType エンジンを使用して文字列の幅と高さを計算するため、
描画結果と完全に一致する正確なバウンディングボックスを返します。

これは、ラベルの配置、センタリング、背景ボックス、地図の注記などに不可欠です。

## 構文

```ruby
width, height = image.text_bbox(text, font:, size:, angle: 0.0)
```

## パラメータ

| 名前 | 型 | 説明 |
|------|----|------|
| `text` | `String` | UTF-8 文字列 |
| `font` | `String` | TrueType または OpenType フォントのパス |
| `size` | `Numeric` | フォントサイズ（ポイント） |
| `angle` | `Float` | 回転角（ラジアン、デフォルト `0.0`） |

## 例

```ruby
w, h = img.text_bbox(
  "東京",
  font: "NotoSans-Bold.ttf",
  size: 32
)

img.filled_rectangle(
  100, 100,
  100 + w + 20,
  100 + h + 20,
  [0, 0, 0, 160]
)

img.text(
  "東京",
  x: 110,
  y: 110 + h,
  font: "NotoSans-Bold.ttf",
  size: 32,
  color: [255,255,255]
)
```

## 注記

- バウンディングボックスはカーニングやヒンティングを含む実際の字形に基づいて計算されます。
- 回転されたテキストにも対応しています。
- `text_ft` と組み合わせることで、地図ラベルやレイアウトエンジンを構築できます。
