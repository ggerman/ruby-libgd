# GD::Image#save（保存）

ファイル拡張子に応じて画像を保存します。

```ruby
save(path, options = nil)
```

### 対応形式
PNG / JPEG / WebP

### 例
```ruby
img.save("map.png")
img.save("photo.jpg", quality: 80)
```
