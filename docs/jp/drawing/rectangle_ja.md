# GD::Image#rectangle（四角形）

画像に四角形の枠線を描画します。

## シグネチャ
```ruby
rectangle(x1, y1, x2, y2, color)
```

## パラメータ
- `x1`, `y1`: 左上の座標
- `x2`, `y2`: 右下の座標
- `color`: `image.color(r,g,b,a=0)` で割り当てた色

## 例
```ruby
img = GD::Image.new(400,300)
red = img.color(255,0,0)
img.rectangle(50,50,200,150,red)
img.save_png("rect.png")
```

## 補足
このメソッドは libgd の `gdImageRectangle` に直接マッピングされています。
