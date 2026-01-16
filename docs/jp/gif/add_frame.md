# add_frame

```ruby
gif.add_frame(image, delay: 50)
```

アニメーションGIFにフレームを追加します。

---

## 概要

`add_frame` は、描画済みの `GD::Image` を
アニメーションGIFの1フレームとして追加します。

フレームは追加された順番で再生されます。

---

## 引数

### `image` (`GD::Image`)

フレームとして使用する画像オブジェクトです。

```ruby
img = GD::Image.new(200, 200)
gif.add_frame(img)
```

---

### `delay` (`Integer`, 任意)

フレームの表示時間を指定します。

- 単位：1/100 秒（centisecond）
- デフォルト：`50`（0.5 秒）

```ruby
gif.add_frame(img, delay: 10)
```

---

## 挙動

- 最初の `add_frame` 呼び出し時に GIF ヘッダが書き込まれます
- 各フレームは差分としてエンコードされます
- フレームは内部的に前のフレームを参照します

---

## 注意事項

- すべてのフレームは同じサイズである必要があります
- 異なるサイズの画像を追加すると、正しく表示されません
- `close` を呼び出すまで GIF は完成しません

---

## 例

```ruby
gif = GD::Gif.new("animation.gif")

10.times do |i|
  img = GD::Image.new(200, 200)

  img.filled_circle(
    100,
    100,
    20 + i * 5,
    GD::Color.rgb(255, 0, 0)
  )

  gif.add_frame(img, delay: 5)
end

gif.close
```

---

## 関連メソッド

- [`GD::Gif.new`](new.md)
- [`close`](close.md)
