# GD::Image#ellipse（楕円）

画像に楕円の枠線を描画します。

## シグネチャ
```ruby
ellipse(cx, cy, width, height, color)
```

## パラメータ
- `cx`, `cy`: 中心座標
- `width`: 楕円の幅
- `height`: 楕円の高さ
- `color`: `image.color(r,g,b,a=0)` で割り当てた色

## 例
```ruby
img = GD::Image.new(400,300)
green = img.color(0,255,0)
img.ellipse(200,150,100,80,green)
img.save_png("ellipse.png")
```

## 補足
このメソッドは libgd の `gdImageEllipse` に対応しています。
