# ruby-libgd — Ruby向けグラフィックス＆画像処理エンジン

`ruby-libgd` は GD C ライブラリを基盤とした Ruby 用のネイティブ 2D ラスターグラフィックスエンジンです。  
`GD::Image` クラスを通じて、描画、テキスト、フィルタ、合成、画像入出力の完全な API を提供します。

---

## コアクラス

| クラス | 説明 |
|------|------|
| `GD::Image` | ラスター画像キャンバス。すべての描画・フィルタ・出力操作を提供 |

---

## キャンバス & コア

| メソッド | 説明 |
|--------|-------------|
| `GD::Image.new` | 新しい TrueColor キャンバスを作成 |
| `GD::Image.new_true_color` | 新しい TrueColor 画像を作成 |
| `GD::Image.open` | 画像をディスクから読み込み |
| `width` | 画像の幅 |
| `height` | 画像の高さ |
| `color` | 色を割り当て（RGBA） |
| `alpha_blending=` | アルファブレンディングの有効 / 無効 |
| `save_alpha=` | アルファチャンネル保存の有効 / 無効 |
| `clone` | 画像を複製 |

---

## 色（Color）

| メソッド | 説明 |
|--------|-------------|
| `GD::Color.rgb` | RGB 色を作成 |
| `GD::Color.rgba` | RGBA 色を作成 |

---

## 描画（Drawing）

| メソッド | 説明 |
|-------|-------------|
| `line` | 直線を描画 |
| `rectangle` | 四角形の枠線を描画 |
| `filled_rectangle` | 塗りつぶし四角形を描画 |
| `ellipse` | 楕円を描画 |
| `filled_ellipse` | 塗りつぶし楕円を描画 |
| `circle` | 線の太さを指定して円を描画 |
| `filled_circle` | 塗りつぶし円を描画 |
| `polygon` | 多角形を描画 |
| `filled_polygon` | 塗りつぶし多角形を描画 |

---

## テキスト（Text）

| メソッド | 説明 |
|--------|-------------|
| `text` | UTF-8 TrueType テキストを描画 |

---

## フィルタ（Filters）

| メソッド | 説明 |
|--------|-------------|
| `filter("negate")` | 色を反転 |
| `filter("grayscale")` | グレースケールに変換 |
| `filter("brightness", v)` | 明るさを調整 |
| `filter("contrast", v)` | コントラストを調整 |
| `filter("colorize", r,g,b,a)` | 色オーバーレイ |
| `filter("sepia")` | セピア調（ruby-libgd 実装） |

---

## 変換（Transformations）

| メソッド | 説明 |
|--------|-------------|
| `crop` | 新しい画像として切り抜き |
| `scale` | 新しい画像としてリサイズ |
| `resize` | `scale` のエイリアス |
| `clone` | 画像を複製 |

---

## 合成（Composition）

| メソッド | 説明 |
|--------|-------------|
| `copy` | 別の画像から領域をコピー |
| `copy_resize` | コピー＋リサイズ（必要に応じてリサンプリング） |

---

## 入出力（Input & Output）

| メソッド | 説明 |
|--------|-------------|
| `GD::Image.open` | 画像を読み込み |
| `save` | PNG / JPEG / WebP で保存 |
| `to_png` | PNG バイト列としてエンコード |
