# GD::Image#line（直線）

2点間に直線を描画します。

## シグネチャ
```ruby
line(x1, y1, x2, y2, color)
```

## パラメータ
- `x1`, `y1`: 開始点
- `x2`, `y2`: 終了点
- `color`: `image.color(r,g,b,a=0)` で割り当てた色

## 例
```ruby
img = GD::Image.new(400,300)
blue = img.color(0,0,255)
img.line(20,20,380,280,blue)
img.save("line.png")
```

## 補足
このメソッドは libgd の `gdImageLine` に直接対応しています。
