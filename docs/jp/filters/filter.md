# GD::Image#filter（画像フィルタ）

画像にピクセル単位のフィルタ処理を適用します。

## シグネチャ
```ruby
filter(type, *args)
```

## 対応フィルタ

### negate（反転）
```ruby
img.filter("negate")
```

### grayscale（グレースケール）
```ruby
img.filter("grayscale")
```

### brightness（明るさ）
```ruby
img.filter("brightness", value)
```
- `value`: 整数（負で暗く、正で明るく）

### contrast（コントラスト）
```ruby
img.filter("contrast", value)
```

### colorize（色のオーバーレイ）
```ruby
img.filter("colorize", r, g, b, a)
```
- `r`, `g`, `b`: 0..255
- `a`: 0..127（GD の alpha）

### sepia（セピア）
```ruby
img.filter("sepia")
```
ruby-libgd 側で実装されたセピア効果です。

## 補足
利用可能なものは libgd のフィルタに対応し、`sepia` は ruby-libgd が提供します。
